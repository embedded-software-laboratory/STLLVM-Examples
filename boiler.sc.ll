; ModuleID = 'boiler'
source_filename = "./bench/boiler.st"

%boiler.state = type { i16, i1, i16 }

define void @boiler.init(%boiler.state* %state) {
entry:
  %state.temperature = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 0
  store i16 0, i16* %state.temperature, align 2
  %state.heater_on = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 1
  store i1 false, i1* %state.heater_on, align 1
  %state.last_temperature = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 2
  store i16 0, i16* %state.last_temperature, align 2
  ret void
}

define void @boiler(%boiler.state* %state) !dbg !3 {
entry:
  %state.temperature = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 0
  %state.heater_on = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 1
  %state.last_temperature = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 2
  %target_temperature = alloca i16, align 2
  store i16 100, i16* %target_temperature, align 2
  %hysteresis = alloca i16, align 2
  store i16 5, i16* %hysteresis, align 2
  %state.temperature.value = load i16, i16* %state.temperature, align 2, !dbg !7
  %state.last_temperature.value = load i16, i16* %state.last_temperature, align 2, !dbg !7
  %0 = icmp sgt i16 %state.temperature.value, %state.last_temperature.value, !dbg !7
  br i1 %0, label %if_then, label %if_else3, !dbg !7

if_then:                                          ; preds = %entry
  %state.temperature.value1 = load i16, i16* %state.temperature, align 2, !dbg !8
  %1 = icmp sgt i16 %state.temperature.value1, 105, !dbg !8
  br i1 %1, label %if_then2, label %if_else, !dbg !8

if_then2:                                         ; preds = %if_then
  store i1 false, i1* %state.heater_on, align 1, !dbg !9
  br label %if_merge, !dbg !9

if_else:                                          ; preds = %if_then
  store i1 true, i1* %state.heater_on, align 1, !dbg !10
  br label %if_merge, !dbg !10

if_merge:                                         ; preds = %if_else, %if_then2
  br label %if_merge8, !dbg !10

if_else3:                                         ; preds = %entry
  %state.temperature.value4 = load i16, i16* %state.temperature, align 2, !dbg !11
  %2 = icmp slt i16 %state.temperature.value4, 100, !dbg !11
  br i1 %2, label %if_then5, label %if_else6, !dbg !11

if_then5:                                         ; preds = %if_else3
  store i1 true, i1* %state.heater_on, align 1, !dbg !12
  br label %if_merge7, !dbg !12

if_else6:                                         ; preds = %if_else3
  store i1 false, i1* %state.heater_on, align 1, !dbg !13
  br label %if_merge7, !dbg !13

if_merge7:                                        ; preds = %if_else6, %if_then5
  br label %if_merge8, !dbg !13

if_merge8:                                        ; preds = %if_merge7, %if_merge
  %state.temperature.value9 = load i16, i16* %state.temperature, align 2, !dbg !14
  store i16 %state.temperature.value9, i16* %state.last_temperature, align 2, !dbg !14
  %state.temperature.value10 = load i16, i16* %state.temperature, align 2, !dbg !15
  %3 = icmp sgt i16 %state.temperature.value10, 105, !dbg !15
  %state.heater_on.value = load i1, i1* %state.heater_on, align 1, !dbg !15
  %4 = and i1 %3, %state.heater_on.value, !dbg !15
  br i1 %4, label %if_then11, label %if_else12, !dbg !15

if_then11:                                        ; preds = %if_merge8
  call void @__VERIFIER_error(), !dbg !16
  br label %if_merge13, !dbg !16

if_else12:                                        ; preds = %if_merge8
  br label %if_merge13, !dbg !16

if_merge13:                                       ; preds = %if_else12, %if_then11
  ret void
}

declare void @__VERIFIER_error()

define void @main() {
entry:
  %state = alloca %boiler.state, align 8
  call void @boiler.init(%boiler.state* %state)
  br label %cycle

cycle:                                            ; preds = %cycle, %entry
  call void @boiler.reinit(%boiler.state* %state)
  call void @boiler(%boiler.state* %state)
  br label %cycle
}

define void @boiler.reinit(%boiler.state* %state) {
entry:
  %state.temperature = getelementptr %boiler.state, %boiler.state* %state, i32 0, i32 0
  %0 = call i16 @nondet_value_for_temperature()
  store i16 %0, i16* %state.temperature, align 2
  ret void
}

declare i16 @nondet_value_for_temperature()

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/boiler.st", directory: ".")
!3 = distinct !DISubprogram(name: "boiler", linkageName: "boiler", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 16, column: 1, scope: !3)
!8 = !DILocation(line: 18, column: 3, scope: !3)
!9 = !DILocation(line: 19, column: 5, scope: !3)
!10 = !DILocation(line: 21, column: 5, scope: !3)
!11 = !DILocation(line: 25, column: 3, scope: !3)
!12 = !DILocation(line: 26, column: 5, scope: !3)
!13 = !DILocation(line: 28, column: 5, scope: !3)
!14 = !DILocation(line: 32, column: 1, scope: !3)
!15 = !DILocation(line: 33, column: 1, scope: !3)
!16 = !DILocation(line: 34, column: 1, scope: !3)
