; ModuleID = 'deref'
source_filename = "./bench/deref.st"

%deref.state = type { i16*, i16 }

@ptr = private unnamed_addr constant [4 x i8] c"ptr\00", align 1

define void @deref.init(%deref.state* %state) {
entry:
  %state.ptr = getelementptr %deref.state, %deref.state* %state, i32 0, i32 0
  store i16* null, i16** %state.ptr, align 8
  %state.out = getelementptr %deref.state, %deref.state* %state, i32 0, i32 1
  store i16 0, i16* %state.out, align 2
  ret void
}

define void @deref(%deref.state* %state) !dbg !3 {
entry:
  %state.ptr = getelementptr %deref.state, %deref.state* %state, i32 0, i32 0
  %state.out = getelementptr %deref.state, %deref.state* %state, i32 0, i32 1
  %state.ptr.value = load i16*, i16** %state.ptr, align 8, !dbg !7
  %state.ptr.value.value = load i16, i16* %state.ptr.value, align 2, !dbg !7
  store i16 %state.ptr.value.value, i16* %state.out, align 2, !dbg !7
  ret void
}

declare void @klee_make_symbolic(i8*, i64, i8*)

define void @main() {
entry:
  %0 = alloca i16*, align 8
  %1 = bitcast i16** %0 to i8*
  call void @klee_make_symbolic(i8* %1, i64 8, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @ptr, i32 0, i32 0))
  call void @deref_wrapper(i16** %0)
  ret void
}

define void @deref_wrapper(i16** %0) {
entry:
  %state = alloca %deref.state, align 8
  call void @deref.init(%deref.state* %state)
  %1 = load i16*, i16** %0, align 8
  %ptr = getelementptr %deref.state, %deref.state* %state, i32 0, i32 0
  store i16* %1, i16** %ptr, align 8
  call void @deref(%deref.state* %state)
  ret void
}

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/deref.st", directory: ".")
!3 = distinct !DISubprogram(name: "deref", linkageName: "deref", scope: null, file: !2, line: 5, type: !4, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 9, column: 3, scope: !3)
