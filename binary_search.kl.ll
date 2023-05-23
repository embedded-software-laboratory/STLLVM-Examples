; ModuleID = 'binary_search'
source_filename = "./bench/binary_search.st"

%binary_search.state = type { i16, [10 x i16], i16 }

@x = private unnamed_addr constant [2 x i8] c"x\00", align 1
@arr = private unnamed_addr constant [4 x i8] c"arr\00", align 1

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
  %2 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %1, !dbg !8
  %.value = load i16, i16* %2, align 2, !dbg !8
  %i.value2 = load i16, i16* %i, align 2, !dbg !8
  %3 = add i16 %i.value2, 1, !dbg !8
  %4 = sub i16 %3, 0, !dbg !8
  %5 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %4, !dbg !8
  %.value3 = load i16, i16* %5, align 2, !dbg !8
  %6 = icmp sle i16 %.value, %.value3, !dbg !8
  %7 = zext i1 %6 to i64, !dbg !8
  call void @klee_assume(i64 %7), !dbg !8
  br label %for_inc, !dbg !8

for_inc:                                          ; preds = %for_body
  %i.value4 = load i16, i16* %i, align 2, !dbg !8
  %8 = add i16 %i.value4, 1, !dbg !8
  store i16 %8, i16* %i, align 2, !dbg !8
  br label %for_header, !dbg !8

for_end:                                          ; preds = %for_header
  store i16 -1, i16* %state.idx, align 2, !dbg !9
  br label %loop_header, !dbg !10

loop_header:                                      ; preds = %if_merge16, %for_end
  %first.value = load i16, i16* %first, align 2, !dbg !10
  %last.value = load i16, i16* %last, align 2, !dbg !10
  %9 = icmp sle i16 %first.value, %last.value, !dbg !10
  br i1 %9, label %loop_body, label %loop_end, !dbg !10

loop_body:                                        ; preds = %loop_header
  %first.value5 = load i16, i16* %first, align 2, !dbg !11
  %last.value6 = load i16, i16* %last, align 2, !dbg !11
  %10 = add i16 %first.value5, %last.value6, !dbg !11
  %11 = sdiv i16 %10, 2, !dbg !11
  store i16 %11, i16* %mid, align 2, !dbg !11
  %mid.value = load i16, i16* %mid, align 2, !dbg !12
  %12 = sub i16 %mid.value, 0, !dbg !12
  %13 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %12, !dbg !12
  %.value7 = load i16, i16* %13, align 2, !dbg !12
  %state.x.value = load i16, i16* %state.x, align 2, !dbg !12
  %14 = icmp eq i16 %.value7, %state.x.value, !dbg !12
  br i1 %14, label %if_then, label %if_else, !dbg !12

if_then:                                          ; preds = %loop_body
  %mid.value8 = load i16, i16* %mid, align 2, !dbg !13
  store i16 %mid.value8, i16* %state.idx, align 2, !dbg !13
  br label %loop_end, !dbg !14

exit_split:                                       ; No predecessors!
  br label %if_merge16, !dbg !14

if_else:                                          ; preds = %loop_body
  %mid.value9 = load i16, i16* %mid, align 2, !dbg !15
  %15 = sub i16 %mid.value9, 0, !dbg !15
  %16 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %15, !dbg !15
  %.value10 = load i16, i16* %16, align 2, !dbg !15
  %state.x.value11 = load i16, i16* %state.x, align 2, !dbg !15
  %17 = icmp sgt i16 %.value10, %state.x.value11, !dbg !15
  br i1 %17, label %if_then12, label %if_else14, !dbg !15

if_then12:                                        ; preds = %if_else
  %mid.value13 = load i16, i16* %mid, align 2, !dbg !16
  %18 = sub i16 %mid.value13, 1, !dbg !16
  store i16 %18, i16* %last, align 2, !dbg !16
  br label %if_merge, !dbg !16

if_else14:                                        ; preds = %if_else
  %mid.value15 = load i16, i16* %mid, align 2, !dbg !17
  %19 = add i16 %mid.value15, 1, !dbg !17
  store i16 %19, i16* %first, align 2, !dbg !17
  br label %if_merge, !dbg !17

if_merge:                                         ; preds = %if_else14, %if_then12
  br label %if_merge16, !dbg !17

if_merge16:                                       ; preds = %if_merge, %exit_split
  br label %loop_header, !dbg !17

loop_end:                                         ; preds = %if_then, %loop_header
  %state.idx.value = load i16, i16* %state.idx, align 2, !dbg !18
  %20 = icmp ne i16 %state.idx.value, -1, !dbg !18
  br i1 %20, label %if_then17, label %if_else24, !dbg !18

if_then17:                                        ; preds = %loop_end
  %state.idx.value18 = load i16, i16* %state.idx, align 2, !dbg !19
  %21 = sub i16 %state.idx.value18, 0, !dbg !19
  %22 = getelementptr [10 x i16], [10 x i16]* %state.arr, i64 0, i16 %21, !dbg !19
  %.value19 = load i16, i16* %22, align 2, !dbg !19
  %state.x.value20 = load i16, i16* %state.x, align 2, !dbg !19
  %23 = icmp ne i16 %.value19, %state.x.value20, !dbg !19
  br i1 %23, label %if_then21, label %if_else22, !dbg !19

if_then21:                                        ; preds = %if_then17
  unreachable, !dbg !20

unreachable_split:                                ; No predecessors!
  br label %if_merge23, !dbg !20

if_else22:                                        ; preds = %if_then17
  br label %if_merge23, !dbg !20

if_merge23:                                       ; preds = %if_else22, %unreachable_split
  br label %if_merge25, !dbg !20

if_else24:                                        ; preds = %loop_end
  br label %if_merge25, !dbg !20

if_merge25:                                       ; preds = %if_else24, %if_merge23
  ret void
}

declare void @klee_assume(i64)

declare void @klee_make_symbolic(i8*, i64, i8*)

define void @main() {
entry:
  %0 = alloca i16, align 2
  %1 = bitcast i16* %0 to i8*
  call void @klee_make_symbolic(i8* %1, i64 2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @x, i32 0, i32 0))
  %2 = alloca [10 x i16], align 2
  %3 = bitcast [10 x i16]* %2 to i8*
  call void @klee_make_symbolic(i8* %3, i64 20, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @arr, i32 0, i32 0))
  call void @binary_search_wrapper(i16* %0, [10 x i16]* %2)
  ret void
}

define void @binary_search_wrapper(i16* %0, [10 x i16]* %1) {
entry:
  %state = alloca %binary_search.state, align 8
  call void @binary_search.init(%binary_search.state* %state)
  %2 = load i16, i16* %0, align 2
  %x = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 0
  store i16 %2, i16* %x, align 2
  %3 = load [10 x i16], [10 x i16]* %1, align 2
  %arr = getelementptr %binary_search.state, %binary_search.state* %state, i32 0, i32 1
  store [10 x i16] %3, [10 x i16]* %arr, align 2
  call void @binary_search(%binary_search.state* %state)
  ret void
}

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
