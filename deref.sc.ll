; ModuleID = 'deref'
source_filename = "./bench/deref.st"

%deref.state = type { i16*, i16 }

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
  %0 = icmp eq i16* %state.ptr.value, null, !dbg !7
  br i1 %0, label %__VERIFIER_error_block, label %ref_valid, !dbg !7

__VERIFIER_error_block:                           ; preds = %entry
  call void @__VERIFIER_error(), !dbg !7
  unreachable, !dbg !7

ref_valid:                                        ; preds = %entry
  %state.ptr.value.value = load i16, i16* %state.ptr.value, align 2, !dbg !7
  store i16 %state.ptr.value.value, i16* %state.out, align 2, !dbg !7
  ret void
}

declare void @__VERIFIER_error()

define void @main() {
entry:
  %state = alloca %deref.state, align 8
  call void @deref.init(%deref.state* %state)
  br label %cycle

cycle:                                            ; preds = %cycle, %entry
  call void @deref.reinit(%deref.state* %state)
  call void @deref(%deref.state* %state)
  br label %cycle
}

define void @deref.reinit(%deref.state* %state) {
entry:
  %state.ptr = getelementptr %deref.state, %deref.state* %state, i32 0, i32 0
  %0 = call i16* @nondet_value_for_ptr()
  store i16* %0, i16** %state.ptr, align 8
  ret void
}

declare i16* @nondet_value_for_ptr()

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
