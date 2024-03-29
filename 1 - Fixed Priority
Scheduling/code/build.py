#! /usr/bin/env python
# -*- coding: UTF-8 -*-
#----------------------------------------------------------------------
#--- Python Build file for application lab1
#--- automatically generated by goil on Fri Dec  8 10:16:07 2017
#--- from root OIL file lab1.oil
#---
#--- Compiling a Trampoline application is done in 2 stages
#--- 1 - From the OIL file, a set of files is generated as long as
#---     build options. Among these files are the build.py and make.py 
#---     files. make.py contains compilation rules when the OIL file
#---     and the included OIL files are modified. make.py is only
#---     written once when the goil command is typed.
#--- 2 - From all the C/assembly files (OS, Application, librairies,
#---     configuration, ...), the objects and the executable are
#---     produced. This is done by the build.py file.
#---     build.py is generated each time goil is called by make.py
#----------------------------------------------------------------------
import sys, os, subprocess, string, distutils.spawn

#--- Add the location of makefile.py to the import path
sys.path.append("/Users/coro-m1-cd/trampoline/make")

#--- Import the makefile system in python
import makefile, projfile

#--- To work with relative paths
scriptDir = os.path.dirname (os.path.abspath (sys.argv[0]))
os.chdir (scriptDir)

#--- Get goal as first argument
askedGoal = "all"
if len (sys.argv) > 1 :
  askedGoal = sys.argv [1]

if askedGoal == "all" or askedGoal == "clean" :
  goal = askedGoal
else :
  goal = "all"

#--- Get max parallel jobs as second argument
maxParallelJobs = 0 # 0 means use host processor count
if len (sys.argv) > 2 :
  maxParallelJobs = int (sys.argv [2])

#--- Instanciate a new makefile object
make = makefile.Make(goal)

#----------------------------------------------------------------------
#--- Various variables used after
#----------------------------------------------------------------------
compiler = "arm-none-eabi-gcc"
cppCompiler = "arm-none-eabi-g++"
linker = "arm-none-eabi-ld"
assembler = "arm-none-eabi-gcc"
autosar = False
autosar_sc = 0
autosar_osapplications = False
with_ioc = False
with_com = False
scheduler = "osek"
trampoline_base_path = "/Users/coro-m1-cd/trampoline/"
cflags = []
cppflags = []
ldflags = []
asflags = []
cppflags += "-fno-rtti".split()
cppflags += "-felide-constructors".split()
cppflags += "-fno-threadsafe-statics".split()
cppflags += "-fno-use-cxa-get-exception-ptr".split()
cppflags += "-fno-enforce-eh-specs".split()
cflags += "-g".split()
cppflags += "-g".split()
cflags += "-Wall".split()
cppflags += "-Wall".split()
cflags += "-Wno-unused-but-set-variable".split()
cppflags += "-Wno-unused-but-set-variable".split()
cflags += "-Wmissing-field-initializers".split()
cppflags += "-Wmissing-field-initializers".split()
cflags += "-mcpu=cortex-m4".split()
cppflags += "-mcpu=cortex-m4".split()
cflags += "-mthumb".split()
cppflags += "-mthumb".split()
cflags += "-mfloat-abi=soft".split()
cppflags += "-mfloat-abi=soft".split()
cflags += "-mfpu=fpv4-sp-d16".split()
cppflags += "-mfpu=fpv4-sp-d16".split()
cflags += "-nostartfiles".split()
cppflags += "-nostartfiles".split()
cflags += "--specs=nosys.specs".split()
cppflags += "--specs=nosys.specs".split()
cflags += "-fno-exceptions".split()
cppflags += "-fno-exceptions".split()
cflags += "-nostdlib".split()
cppflags += "-nostdlib".split()
cflags += "-ffunction-sections".split()
cppflags += "-ffunction-sections".split()
cflags += "-fdata-sections".split()
cppflags += "-fdata-sections".split()
cflags += "-DARDUINO=10603 -DTEENSYDUINO=124 -DF_CPU=96000000".split()
cppflags += "-DARDUINO=10603 -DTEENSYDUINO=124 -DF_CPU=96000000".split()
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/CMSIS/Include"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/CMSIS/Include"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/avr"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/avr"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/LiquidCrystalFast"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/LiquidCrystalFast"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/Print"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/Print"]
cflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/WString"]
cppflags += ["-I","/Users/coro-m1-cd/trampoline/machines/cortex/armv7/mk20dx256/teensy31/libraries/WString"]
if with_ioc:
  cflags += ["-I", "/Users/coro-m1-cd/trampoline/ioc"] 
  cppflags += ["-I", "/Users/coro-m1-cd/trampoline/ioc"] 
cflags += ["-I", "/Users/coro-m1-cd/trampoline/os"] 
cflags += ["-I", "/Users/coro-m1-cd/trampoline/debug"] 
cflags += ["-I", "lab1"]
cppflags += ["-I", "/Users/coro-m1-cd/trampoline/os"] 
cppflags += ["-I", "/Users/coro-m1-cd/trampoline/debug"] 
cppflags += ["-I", "lab1"]
ldflags += "--fatal-warnings".split()
ldflags += "--warn-common".split()
ldflags += "--no-undefined".split()
ldflags += "--gc-sections".split()
ldflags += ["-T", "lab1/script.ld"]
asflags += "-g".split()
asflags += "-Wall".split()
asflags += "-mcpu=cortex-m4".split()
asflags += "-mthumb".split()
asflags += "--fatal-warnings".split()
asflags += "-mfloat-abi=soft".split()
asflags += "-mfpu=fpv4-sp-d16".split()


#----------------------------------------------------------------------
#--- Try to detect automatically the location of libc and libgcc
#--- This supposes the compiler has a (something)-gcc name
#----------------------------------------------------------------------
if "gcc" in compiler:
  compilerFullPath = makefile.find_executable(compiler)
  if compilerFullPath != None:
    #--- Extract the (something) from the compiler executable name
    compilerParts = compiler.split('-')
    compilerParts.pop()
    compilerPrefix = "-".join(compilerParts)
    #--- Get the full path of the compiler
    compilerToolChainPath = os.path.dirname(os.path.dirname(compilerFullPath))
    #--- Get the version of the compiler, [:-1] removes the carriage return
    compilerVersion = subprocess.check_output([compiler, '-dumpversion'])[:-1]
    #--- Build the libc path
    libcPath = compilerToolChainPath + '/' + compilerPrefix + '/lib/armv7e-m'
    #--- Build the libgcc path
    libgccPath = compilerToolChainPath + '/lib/gcc/' + compilerPrefix + '/' + compilerVersion + '/armv7e-m'
    #--- Add both to linker flags
    ldflags += ['-L' + libcPath, '-lc']
    ldflags += ['-L' + libgccPath, '-lgcc']

#----------------------------------------------------------------------
#--- Build the source files list
#----------------------------------------------------------------------
cSourceList = []
cppSourceList = []
sSourceList = []
oilSourceList = []

#--- OIL file
oilSourceList.append("lab1.oil")

#--- Kernel files 
cSourceList.append(projfile.ProjectFile("os/tpl_os_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_timeobj_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_action.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_error.c", trampoline_base_path))

#--- Services files
cSourceList.append(projfile.ProjectFile("os/tpl_os_os_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_os.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_interrupt_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_task_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_resource_kernel.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("os/tpl_os_event_kernel.c", trampoline_base_path))

#--- Add C++ files of the application
cppSourceList.append(projfile.ProjectFile("lab1.cpp"))

#--- Add generated files
cSourceList.append(projfile.ProjectFile("lab1/tpl_app_config.c"))

cSourceList.append(projfile.ProjectFile("lab1/tpl_dispatch_table.c"))
cSourceList.append(projfile.ProjectFile("lab1/tpl_invoque.S"))
cSourceList.append(projfile.ProjectFile("lab1/tpl_primary_irq.S"))
cSourceList.append(projfile.ProjectFile("lab1/tpl_vectors.c"))
cSourceList.append(projfile.ProjectFile("lab1/tpl_external_interrupts.c"))
cSourceList.append(projfile.ProjectFile("machines/cortex/tpl_machine_cortex.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/tpl_system_call.S", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/tpl_ctx_switch.S", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/tpl_startup.S", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/tpl_machine_mk20dx256.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/handlers_mk20dx256.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/startup_mk20dx256.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/syscalls.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/gpio.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/itoa.c", trampoline_base_path))
cSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/avr/dtostrf.c", trampoline_base_path))
cppSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/libraries/LiquidCrystalFast/LiquidCrystalFast.cpp", trampoline_base_path))
cppSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/libraries/Print/Print.cpp", trampoline_base_path))
cppSourceList.append(projfile.ProjectFile("machines/cortex/armv7/mk20dx256/teensy31/libraries/WString/WString.cpp", trampoline_base_path))
#----------------------------------------------------------------------
#--- Build the object list and the compiler dependancies
#----------------------------------------------------------------------
objectList = []

for sourceFile in cSourceList:
  source = sourceFile.src() 
  object = sourceFile.obj("build")
  depObject = sourceFile.dep("build")
  objectList.append(object)
  rule = makefile.Rule([object], "Compiling " + source)
  rule.deleteTargetDirectoryOnClean()
  rule.mDependences.append(source)
  rule.mCommand.append(compiler)
  rule.mCommand += ["-c", source]
  rule.mCommand += ["-o", object]
  rule.mCommand += ["-MD", "-MP", "-MF", depObject]
  rule.mCommand += cflags
  rule.enterSecondaryDependanceFile (depObject, make)
  make.addRule(rule)

for sourceFile in cppSourceList:
  source = sourceFile.src() 
  object = sourceFile.obj("build")
  depObject = sourceFile.dep("build")
  objectList.append(object)
  rule = makefile.Rule([object], "Compiling " + source)
  rule.deleteTargetDirectoryOnClean()
  rule.mDependences.append(source)
  rule.mCommand.append(cppCompiler)
  rule.mCommand += ["-c", source]
  rule.mCommand += ["-o", object]
  rule.mCommand += ["-MD", "-MP", "-MF", depObject]
  rule.mCommand += cppflags
  rule.enterSecondaryDependanceFile (depObject, make)
  make.addRule(rule)

for sourceFile in sSourceList:
  source = sourceFile.src() 
  object = sourceFile.obj("build")
  objectList.append(object)
  rule = makefile.Rule([object], "Assembling " + source)
  rule.mDependences.append(source)
  rule.mCommand.append(assembler)
  rule.mCommand += ["-c", source]
  rule.mCommand += ["-o", object]
  rule.mCommand += asflags
  make.addRule(rule)

product = "lab1_exe"
rule = makefile.Rule ([product], "Linking " + product)
rule.deleteTargetFileOnClean()
rule.mDeleteTargetOnError = True
rule.mDependences += objectList
rule.mCommand += [linker]
rule.mCommand += ["-o", product]
rule.mCommand += objectList
rule.mCommand += ldflags
if True:
  postCommand = makefile.PostCommand("Generating binary lab1_exe.hex from lab1_exe")
  postCommand.mCommand.append("arm-none-eabi-objcopy")
  postCommand.mCommand += "-O ihex".split()
  postCommand.mCommand.append("lab1_exe")
  postCommand.mCommand.append("lab1_exe.hex")
  rule.mPostCommands.append(postCommand)

make.addRule (rule)

make.addGoal("all", [product], "Building all")
make.addGoal("compile", objectList, "Compile source files")


make.runGoal(maxParallelJobs, maxParallelJobs == 1)

#----------------------------------------------------------------------
#--- post commands
#----------------------------------------------------------------------
if make.errorCount() == 0:
  if askedGoal == "burn" :
    if makefile.find_executable("teensy-loader-cli") != None:
      subprocess.call("teensy-loader-cli -w -v -mmcu=mk20dx256 lab1_exe.hex ".split())
    else:
      print("Command 'teensy-loader-cli' not in PATH")

#----------------------------------------------------------------------
#-- End of build.py
#----------------------------------------------------------------------

