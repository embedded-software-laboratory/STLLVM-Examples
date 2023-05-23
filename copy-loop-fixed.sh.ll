; ModuleID = 'pcopy'
source_filename = "./bench/copy-loop-fixed.st"

%pcopy.state = type { i16, i16 }

define void @pcopy.init(%pcopy.state* %state) {
entry:
  %state.i = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 0
  %0 = call i16 @nondet_value_for_i()
  store i16 %0, i16* %state.i, align 2
  %state.o = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 1
  %1 = call i16 @nondet_value_for_o()
  store i16 %1, i16* %state.o, align 2
  ret void
}

declare i16 @nondet_value_for_i()

declare i16 @nondet_value_for_o()

define void @pcopy(%pcopy.state* %state) !dbg !3 {
entry:
  %state.i = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 0
  %state.o = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 1
  store i16 0, i16* %state.o, align 2, !dbg !7
  %state.i.value = load i16, i16* %state.i, align 2, !dbg !8
  %0 = icmp sgt i16 %state.i.value, 0, !dbg !8
  br i1 %0, label %if_then, label %if_else, !dbg !8

if_then:                                          ; preds = %entry
  br label %loop_header, !dbg !9

loop_header:                                      ; preds = %loop_body, %if_then
  %state.i.value1 = load i16, i16* %state.i, align 2, !dbg !9
  %1 = icmp sgt i16 %state.i.value1, 0, !dbg !9
  br i1 %1, label %loop_body, label %loop_end, !dbg !9

loop_body:                                        ; preds = %loop_header
  %state.i.value2 = load i16, i16* %state.i, align 2, !dbg !10
  %2 = sub i16 %state.i.value2, 1, !dbg !10
  store i16 %2, i16* %state.i, align 2, !dbg !10
  %state.o.value = load i16, i16* %state.o, align 2, !dbg !11
  %3 = add i16 %state.o.value, 1, !dbg !11
  store i16 %3, i16* %state.o, align 2, !dbg !11
  br label %loop_header, !dbg !11

loop_end:                                         ; preds = %loop_header
  br label %if_merge, !dbg !11

if_else:                                          ; preds = %entry
  br label %loop_header3, !dbg !12

loop_header3:                                     ; preds = %loop_body5, %if_else
  %state.i.value4 = load i16, i16* %state.i, align 2, !dbg !12
  %4 = icmp slt i16 %state.i.value4, 0, !dbg !12
  br i1 %4, label %loop_body5, label %loop_end8, !dbg !12

loop_body5:                                       ; preds = %loop_header3
  %state.i.value6 = load i16, i16* %state.i, align 2, !dbg !13
  %5 = add i16 %state.i.value6, 1, !dbg !13
  store i16 %5, i16* %state.i, align 2, !dbg !13
  %state.o.value7 = load i16, i16* %state.o, align 2, !dbg !14
  %6 = sub i16 %state.o.value7, 1, !dbg !14
  store i16 %6, i16* %state.o, align 2, !dbg !14
  br label %loop_header3, !dbg !14

loop_end8:                                        ; preds = %loop_header3
  br label %if_merge, !dbg !14

if_merge:                                         ; preds = %loop_end8, %loop_end
  ret void
}

define void @main() {
entry:
  %state = alloca %pcopy.state, align 8
  call void @pcopy.init(%pcopy.state* %state)
  call void @pcopy(%pcopy.state* %state)
  ret void
}

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/copy-loop-fixed.st", directory: ".")
!3 = distinct !DISubprogram(name: "pcopy", linkageName: "pcopy", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 5, column: 1, scope: !3)
!8 = !DILocation(line: 6, column: 1, scope: !3)
!9 = !DILocation(line: 7, column: 3, scope: !3)
!10 = !DILocation(line: 8, column: 5, scope: !3)
!11 = !DILocation(line: 9, column: 5, scope: !3)
!12 = !DILocation(line: 12, column: 3, scope: !3)
!13 = !DILocation(line: 13, column: 5, scope: !3)
!14 = !DILocation(line: 14, column: 5, scope: !3)
