package main

import (
	"os"
	"strings"
	"time"

	"github.com/jaypipes/ghw"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/mem"

	"github.com/NVIDIA/go-nvml/pkg/nvml"
	//"github.com/ROCm/rocm-systems/projects/amdsmi"

	"encoding/json"
)

type Metrics struct {
	//CPU
	CPUUSAGE int 	`json:"cpu_usage"`
	CPUCLOCK int `json:"cpu_clock"`

	//RAM
	RAMTOTAL float32 `json:"ram_total"`
	RAMUSED float32 `json:"ram_used"`
	RAMFREE float32 `json:"ram_free"`
	RAMUSAGE int `json:"ram_usage"`

	//GPU
	GPUVENDOR string `json:"gpu_vendor"`
	GPUCLOCK int `json:"gpu_clock"`

    //VRAM
	VRAMTOTAL float32 `json:"vram_total"`
	VRAMUSED float32 `json:"vram_used"`
	VRAMFREE float32 `json:"vram_free"`
	VRAMUSAGE int `json:"vram_usage"`
}

func main()  {

	//Get GPU vendor to filter by gpu company, only nvidia now but may or may not intel and amd
	gpuVendor:= getGpuVendor()

	// Load nvidia drivers if vendor is nvidia, loaded one time for more efficienty, maybe
	if strings.Contains(gpuVendor, "NVIDIA") {
		nvml.Init()
		defer nvml.Shutdown()
	}

	var vramTotal, vramFree, vramUsed float32
	var gpuClock int

	for {

		//Get vram and gpu clock from function
		if strings.Contains(gpuVendor, "NVIDIA") {
			vramTotal, vramFree, vramUsed, gpuClock= getVramNvidia()
		}

		vramUsage:= int(100*(vramUsed/vramTotal))

		cpuUsageF, _ := cpu.Percent(500*time.Millisecond, false)
		cpuUsage := int(cpuUsageF[0])



		v, _ := mem.VirtualMemory()

		ramTotal := float32(v.Total)/1073741824.00
		ramFree := float32(v.Available)/1073741824.00
		ramUsed := float32(v.Used)/1073741824.00
		ramUsage := int(100*((ramUsed)/ramTotal))

		metrics := Metrics {
			CPUUSAGE: cpuUsage,
			RAMTOTAL: ramTotal,
			RAMUSED: ramUsed,
			RAMFREE: ramFree,
			RAMUSAGE: ramUsage,
			GPUVENDOR: gpuVendor,
			VRAMTOTAL: vramTotal,
			VRAMUSED: vramUsed,
			VRAMFREE: vramFree,
			VRAMUSAGE: vramUsage,
			GPUCLOCK: gpuClock,
		}

		jsonData, _:= json.MarshalIndent(metrics, "", "  ")
		os.WriteFile("metrics.json", jsonData, 0644)

		/* print for future debug, just remember to import fmt

		fmt.Printf("CPU Usage: %v %% \n \n", cpuUsage)

		fmt.Printf("RAM Total : %.2f GB \n", ramTotal)
		fmt.Printf("RAM Usage: %v %% \n", ramUsage)
		fmt.Printf("RAM Available: %.2f GB \n", ramFree)
		fmt.Printf("RAM Used: %.2f GB \n \n", ramUsed)

		fmt.Printf("GPU Vendor usage: %v \n", gpuVendor)

		fmt.Printf("vRAM Total : %.2f GB \n", vramTotal)
		fmt.Printf("vRAM Total : %.2f GB \n", vramUsage)
		fmt.Printf("vRAM Free : %.2f GB \n", vramFree)
		fmt.Printf("vRAM Used : %.2f GB \n \n \n", vramUsed) */


	}
}


func getGpuVendor() string {
	gpu, err:= ghw.GPU()

	// error handling
	if err == nil && len(gpu.GraphicsCards) > 0 {
		return gpu.GraphicsCards[0].DeviceInfo.Vendor.Name
	}
	return "Unknown"
}

func getVramNvidia() (float32, float32, float32, int) {

	device, _ := nvml.DeviceGetHandleByIndex(0)
	memory, _ := device.GetMemoryInfo()
	clock, _ := device.GetClockInfo(nvml.CLOCK_GRAPHICS)


	return float32(memory.Total)/1073741824, float32(memory.Free)/1073741824,  float32(memory.Used)/1073741824, int(clock)
}
