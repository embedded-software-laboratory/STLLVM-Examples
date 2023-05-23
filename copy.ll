; ModuleID = 'pcopy'
source_filename = "./bench/copy.st"

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
  %state.i.value = load i16, i16* %state.i, align 2, !dbg !7
  store i16 %state.i.value, i16* %state.o, align 2, !dbg !7
  ret void
}

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/copy.st", directory: ".")
!3 = distinct !DISubprogram(name: "pcopy", linkageName: "pcopy", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 5, column: 1, scope: !3)
