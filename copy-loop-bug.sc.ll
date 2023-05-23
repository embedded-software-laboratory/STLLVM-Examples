; ModuleID = 'pcopy'
source_filename = "./bench/copy-loop-bug.st"

%pcopy.state = type { i16, i16 }

define void @pcopy.init(%pcopy.state* %state) {
entry:
  %state.i = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 0
  store i16 0, i16* %state.i, align 2
  %state.o = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 1
  store i16 0, i16* %state.o, align 2
  ret void
}

define void @pcopy(%pcopy.state* %state) !dbg !3 {
entry:
  %state.i = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 0
  %state.o = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 1
  store i16 0, i16* %state.o, align 2, !dbg !7
  br label %loop_header, !dbg !8

loop_header:                                      ; preds = %loop_body, %entry
  %state.i.value = load i16, i16* %state.i, align 2, !dbg !8
  %0 = icmp sgt i16 %state.i.value, 0, !dbg !8
  br i1 %0, label %loop_body, label %loop_end, !dbg !8

loop_body:                                        ; preds = %loop_header
  %state.i.value1 = load i16, i16* %state.i, align 2, !dbg !9
  %1 = sub i16 %state.i.value1, 1, !dbg !9
  store i16 %1, i16* %state.i, align 2, !dbg !9
  %state.o.value = load i16, i16* %state.o, align 2, !dbg !10
  %2 = add i16 %state.o.value, 1, !dbg !10
  store i16 %2, i16* %state.o, align 2, !dbg !10
  br label %loop_header, !dbg !10

loop_end:                                         ; preds = %loop_header
  ret void
}

define void @main() {
entry:
  %state = alloca %pcopy.state, align 8
  call void @pcopy.init(%pcopy.state* %state)
  br label %cycle

cycle:                                            ; preds = %cycle, %entry
  call void @pcopy.reinit(%pcopy.state* %state)
  call void @pcopy(%pcopy.state* %state)
  br label %cycle
}

define void @pcopy.reinit(%pcopy.state* %state) {
entry:
  %state.i = getelementptr %pcopy.state, %pcopy.state* %state, i32 0, i32 0
  %0 = call i16 @nondet_value_for_i()
  store i16 %0, i16* %state.i, align 2
  ret void
}

declare i16 @nondet_value_for_i()

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/copy-loop-bug.st", directory: ".")
!3 = distinct !DISubprogram(name: "pcopy", linkageName: "pcopy", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 5, column: 1, scope: !3)
!8 = !DILocation(line: 6, column: 1, scope: !3)
!9 = !DILocation(line: 7, column: 3, scope: !3)
!10 = !DILocation(line: 8, column: 3, scope: !3)
