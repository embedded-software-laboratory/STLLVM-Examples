; ModuleID = 'buffer'
source_filename = "./bench/buffer.st"

%buffer.state = type { i16, i16, i16 }

@buf = global [1025 x i16] zeroinitializer

define void @buffer.init(%buffer.state* %state) {
entry:
  %state.value = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 0
  store i16 0, i16* %state.value, align 2
  %state.offset = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 1
  store i16 0, i16* %state.offset, align 2
  %state.cur_pos = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 2
  store i16 0, i16* %state.cur_pos, align 2
  ret void
}

define void @buffer(%buffer.state* %state) !dbg !3 {
entry:
  %state.value = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 0
  %state.offset = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 1
  %state.cur_pos = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 2
  %state.offset.value = load i16, i16* %state.offset, align 2, !dbg !7
  %0 = icmp slt i16 %state.offset.value, 0, !dbg !7
  br i1 %0, label %if_then, label %if_else, !dbg !7

if_then:                                          ; preds = %entry
  ret void, !dbg !8

return_split:                                     ; No predecessors!
  br label %if_merge, !dbg !8

if_else:                                          ; preds = %entry
  br label %if_merge, !dbg !8

if_merge:                                         ; preds = %if_else, %return_split
  %state.cur_pos.value = load i16, i16* %state.cur_pos, align 2, !dbg !9
  %state.offset.value1 = load i16, i16* %state.offset, align 2, !dbg !9
  %1 = add i16 %state.cur_pos.value, %state.offset.value1, !dbg !9
  %2 = icmp sgt i16 %1, 1024, !dbg !9
  br i1 %2, label %if_then2, label %if_else4, !dbg !9

if_then2:                                         ; preds = %if_merge
  ret void, !dbg !10

return_split3:                                    ; No predecessors!
  br label %if_merge5, !dbg !10

if_else4:                                         ; preds = %if_merge
  br label %if_merge5, !dbg !10

if_merge5:                                        ; preds = %if_else4, %return_split3
  %state.cur_pos.value6 = load i16, i16* %state.cur_pos, align 2, !dbg !11
  %state.offset.value7 = load i16, i16* %state.offset, align 2, !dbg !11
  %3 = add i16 %state.cur_pos.value6, %state.offset.value7, !dbg !11
  store i16 %3, i16* %state.cur_pos, align 2, !dbg !11
  %state.cur_pos.value8 = load i16, i16* %state.cur_pos, align 2, !dbg !12
  %4 = sub i16 %state.cur_pos.value8, 0, !dbg !12
  %5 = icmp sge i16 %state.cur_pos.value8, 0, !dbg !12
  %6 = icmp sle i16 %state.cur_pos.value8, 1024, !dbg !12
  %7 = and i1 %5, %6, !dbg !12
  br i1 %7, label %subrange_valid, label %__VERIFIER_error_block, !dbg !12

__VERIFIER_error_block:                           ; preds = %if_merge5
  call void @__VERIFIER_error(), !dbg !12
  unreachable, !dbg !12

subrange_valid:                                   ; preds = %if_merge5
  %8 = getelementptr [1025 x i16], [1025 x i16]* @buf, i64 0, i16 %4, !dbg !12
  %state.value.value = load i16, i16* %state.value, align 2, !dbg !12
  store i16 %state.value.value, i16* %8, align 2, !dbg !12
  ret void
}

declare void @__VERIFIER_error()

define void @main() {
entry:
  %state = alloca %buffer.state, align 8
  call void @buffer.init(%buffer.state* %state)
  br label %cycle

cycle:                                            ; preds = %cycle, %entry
  call void @buffer.reinit(%buffer.state* %state)
  call void @buffer(%buffer.state* %state)
  br label %cycle
}

define void @buffer.reinit(%buffer.state* %state) {
entry:
  %state.value = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 0
  %0 = call i16 @nondet_value_for_value()
  store i16 %0, i16* %state.value, align 2
  %state.offset = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 1
  %1 = call i16 @nondet_value_for_offset()
  store i16 %1, i16* %state.offset, align 2
  ret void
}

declare i16 @nondet_value_for_value()

declare i16 @nondet_value_for_offset()

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/buffer.st", directory: ".")
!3 = distinct !DISubprogram(name: "buffer", linkageName: "buffer", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 7, column: 1, scope: !3)
!8 = !DILocation(line: 7, column: 20, scope: !3)
!9 = !DILocation(line: 8, column: 1, scope: !3)
!10 = !DILocation(line: 8, column: 33, scope: !3)
!11 = !DILocation(line: 10, column: 1, scope: !3)
!12 = !DILocation(line: 11, column: 1, scope: !3)
