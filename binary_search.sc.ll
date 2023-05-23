; ModuleID = 'binary_search'
source_filename = "./bench/binary_search.st"

%binary_search.state = type { i16, [10 x i16], i16 }

define void @binary_search.init(%binary_search.state* %state) {
entry:
  %state.x = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 0
  store i16 0, i16* %state.x, align 2
  %state.arr = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 1
  br label %array_init_loop

array_init_loop:                                  ; preds = %array_init_inc, %entry
  %0 = phi i64 [ 0, %entry ], [ %2, %array_init_inc ]
  %1 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i64 %0
  store i16 0, i16* %1, align 2
  br label %array_init_inc

array_init_inc:                                   ; preds = %array_init_loop
  %2 = add i64 %0, 1
  %3 = icmp ult i64 %2, 10
  br i1 %3, label %array_init_loop, label %array_init_end

array_init_end:                                   ; preds = %array_init_inc
  %state.idx = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 2
  store i16 0, i16* %state.idx, align 2
  ret void
}

define void @binary_search(%binary_search.state* %state) !dbg !3 {
entry:
  %state.x = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 0
  %state.arr = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 1
  %state.idx = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 2
  %i = alloca i16, align 2
  store i16 0, i16* %i, align 2
  %first = alloca i16, align 2
  store i16 0, i16* %first, align 2
  %last = alloca i16, align 2
  store i16 9, i16* %last, align 2
  %mid = alloca i16, align 2
  store i16 0, i16* %mid, align 2
  store i16 0, i16* %i, align 2, !dbg !7
  br label %for_header, !dbg !7

for_header:                                       ; preds = %for_inc, %entry
  %i.value = load i16, i16* %i, align 2, !dbg !7
  %0 = icmp sle i16 %i.value, 8, !dbg !7
  br i1 %0, label %for_body, label %for_end, !dbg !7

for_body:                                         ; preds = %for_header
  %i.value1 = load i16, i16* %i, align 2, !dbg !8
  %1 = sub i16 %i.value1, 0, !dbg !8
  %2 = icmp sge i16 %i.value1, 0, !dbg !8
  %3 = icmp sle i16 %i.value1, 9, !dbg !8
  %4 = and i1 %2, %3, !dbg !8
  br i1 %4, label %subrange_valid, label %__VERIFIER_error_block, !dbg !8

__VERIFIER_error_block:                           ; preds = %if_then20, %if_else, %non_zero_division, %loop_body, %subrange_valid, %for_body
  call void @__VERIFIER_error(), !dbg !8
  unreachable, !dbg !8

subrange_valid:                                   ; preds = %for_body
  %5 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %1, !dbg !8
  %.value = load i16, i16* %5, align 2, !dbg !8
  %i.value2 = load i16, i16* %i, align 2, !dbg !8
  %6 = add i16 %i.value2, 1, !dbg !8
  %7 = sub i16 %6, 0, !dbg !8
  %8 = icmp sge i16 %6, 0, !dbg !8
  %9 = icmp sle i16 %6, 9, !dbg !8
  %10 = and i1 %8, %9, !dbg !8
  br i1 %10, label %subrange_valid3, label %__VERIFIER_error_block, !dbg !8

subrange_valid3:                                  ; preds = %subrange_valid
  %11 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %7, !dbg !8
  %.value4 = load i16, i16* %11, align 2, !dbg !8
  %12 = icmp sle i16 %.value, %.value4, !dbg !8
  %13 = zext i1 %12 to i32, !dbg !8
  call void @__VERIFIER_assume(i32 %13), !dbg !8
  br label %for_inc, !dbg !8

for_inc:                                          ; preds = %subrange_valid3
  %i.value5 = load i16, i16* %i, align 2, !dbg !8
  %14 = add i16 %i.value5, 1, !dbg !8
  store i16 %14, i16* %i, align 2, !dbg !8
  br label %for_header, !dbg !8

for_end:                                          ; preds = %for_header
  store i16 -1, i16* %state.idx, align 2, !dbg !9
  br label %loop_header, !dbg !10

loop_header:                                      ; preds = %if_merge19, %for_end
  %first.value = load i16, i16* %first, align 2, !dbg !10
  %last.value = load i16, i16* %last, align 2, !dbg !10
  %15 = icmp sle i16 %first.value, %last.value, !dbg !10
  br i1 %15, label %loop_body, label %loop_end, !dbg !10

loop_body:                                        ; preds = %loop_header
  %first.value6 = load i16, i16* %first, align 2, !dbg !11
  %last.value7 = load i16, i16* %last, align 2, !dbg !11
  %16 = add i16 %first.value6, %last.value7, !dbg !11
  br i1 false, label %__VERIFIER_error_block, label %non_zero_division, !dbg !11

non_zero_division:                                ; preds = %loop_body
  %17 = sdiv i16 %16, 2, !dbg !11
  store i16 %17, i16* %mid, align 2, !dbg !11
  %mid.value = load i16, i16* %mid, align 2, !dbg !12
  %18 = sub i16 %mid.value, 0, !dbg !12
  %19 = icmp sge i16 %mid.value, 0, !dbg !12
  %20 = icmp sle i16 %mid.value, 9, !dbg !12
  %21 = and i1 %19, %20, !dbg !12
  br i1 %21, label %subrange_valid8, label %__VERIFIER_error_block, !dbg !12

subrange_valid8:                                  ; preds = %non_zero_division
  %22 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %18, !dbg !12
  %.value9 = load i16, i16* %22, align 2, !dbg !12
  %state.x.value = load i16, i16* %state.x, align 2, !dbg !12
  %23 = icmp eq i16 %.value9, %state.x.value, !dbg !12
  br i1 %23, label %if_then, label %if_else, !dbg !12

if_then:                                          ; preds = %subrange_valid8
  %mid.value10 = load i16, i16* %mid, align 2, !dbg !13
  store i16 %mid.value10, i16* %state.idx, align 2, !dbg !13
  br label %loop_end, !dbg !14

exit_split:                                       ; No predecessors!
  br label %if_merge19, !dbg !14

if_else:                                          ; preds = %subrange_valid8
  %mid.value11 = load i16, i16* %mid, align 2, !dbg !15
  %24 = sub i16 %mid.value11, 0, !dbg !15
  %25 = icmp sge i16 %mid.value11, 0, !dbg !15
  %26 = icmp sle i16 %mid.value11, 9, !dbg !15
  %27 = and i1 %25, %26, !dbg !15
  br i1 %27, label %subrange_valid12, label %__VERIFIER_error_block, !dbg !15

subrange_valid12:                                 ; preds = %if_else
  %28 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %24, !dbg !15
  %.value13 = load i16, i16* %28, align 2, !dbg !15
  %state.x.value14 = load i16, i16* %state.x, align 2, !dbg !15
  %29 = icmp sgt i16 %.value13, %state.x.value14, !dbg !15
  br i1 %29, label %if_then15, label %if_else17, !dbg !15

if_then15:                                        ; preds = %subrange_valid12
  %mid.value16 = load i16, i16* %mid, align 2, !dbg !16
  %30 = sub i16 %mid.value16, 1, !dbg !16
  store i16 %30, i16* %last, align 2, !dbg !16
  br label %if_merge, !dbg !16

if_else17:                                        ; preds = %subrange_valid12
  %mid.value18 = load i16, i16* %mid, align 2, !dbg !17
  %31 = add i16 %mid.value18, 1, !dbg !17
  store i16 %31, i16* %first, align 2, !dbg !17
  br label %if_merge, !dbg !17

if_merge:                                         ; preds = %if_else17, %if_then15
  br label %if_merge19, !dbg !17

if_merge19:                                       ; preds = %if_merge, %exit_split
  br label %loop_header, !dbg !17

loop_end:                                         ; preds = %if_then, %loop_header
  %state.idx.value = load i16, i16* %state.idx, align 2, !dbg !18
  %32 = icmp ne i16 %state.idx.value, -1, !dbg !18
  br i1 %32, label %if_then20, label %if_else28, !dbg !18

if_then20:                                        ; preds = %loop_end
  %state.idx.value21 = load i16, i16* %state.idx, align 2, !dbg !19
  %33 = sub i16 %state.idx.value21, 0, !dbg !19
  %34 = icmp sge i16 %state.idx.value21, 0, !dbg !19
  %35 = icmp sle i16 %state.idx.value21, 9, !dbg !19
  %36 = and i1 %34, %35, !dbg !19
  br i1 %36, label %subrange_valid22, label %__VERIFIER_error_block, !dbg !19

subrange_valid22:                                 ; preds = %if_then20
  %37 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %33, !dbg !19
  %.value23 = load i16, i16* %37, align 2, !dbg !19
  %state.x.value24 = load i16, i16* %state.x, align 2, !dbg !19
  %38 = icmp ne i16 %.value23, %state.x.value24, !dbg !19
  br i1 %38, label %if_then25, label %if_else26, !dbg !19

if_then25:                                        ; preds = %subrange_valid22
  call void @__VERIFIER_error(), !dbg !20
  br label %if_merge27, !dbg !20

if_else26:                                        ; preds = %subrange_valid22
  br label %if_merge27, !dbg !20

if_merge27:                                       ; preds = %if_else26, %if_then25
  br label %if_merge29, !dbg !20

if_else28:                                        ; preds = %loop_end
  br label %if_merge29, !dbg !20

if_merge29:                                       ; preds = %if_else28, %if_merge27
  ret void
}

declare void @__VERIFIER_error()

declare void @__VERIFIER_assume(i32)

define void @main() {
entry:
  %state = alloca %binary_search.state, align 8
  call void @binary_search.init(%binary_search.state* %state)
  br label %cycle

cycle:                                            ; preds = %cycle, %entry
  call void @binary_search.reinit(%binary_search.state* %state)
  call void @binary_search(%binary_search.state* %state)
  br label %cycle
}

define void @binary_search.reinit(%binary_search.state* %state) {
entry:
  %state.x = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 0
  %0 = call i16 @nondet_value_for_x()
  store i16 %0, i16* %state.x, align 2
  %state.arr = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 1
  %1 = call [10 x i16] @nondet_value_for_arr()
  store [10 x i16] %1, [10 x i16]* %state.arr, align 2
  ret void
}

declare i16 @nondet_value_for_x()

declare [10 x i16] @nondet_value_for_arr()

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/binary_search.st", directory: ".")
!3 = distinct !DISubprogram(name: "binary_search", linkageName: "binary_search", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 12, column: 1, scope: !3)
!8 = !DILocation(line: 13, column: 3, scope: !3)
!9 = !DILocation(line: 16, column: 1, scope: !3)
!10 = !DILocation(line: 17, column: 1, scope: !3)
!11 = !DILocation(line: 18, column: 3, scope: !3)
!12 = !DILocation(line: 19, column: 3, scope: !3)
!13 = !DILocation(line: 20, column: 5, scope: !3)
!14 = !DILocation(line: 21, column: 5, scope: !3)
!15 = !DILocation(line: 22, column: 3, scope: !3)
!16 = !DILocation(line: 23, column: 5, scope: !3)
!17 = !DILocation(line: 25, column: 5, scope: !3)
!18 = !DILocation(line: 29, column: 1, scope: !3)
!19 = !DILocation(line: 30, column: 3, scope: !3)
!20 = !DILocation(line: 31, column: 5, scope: !3)
