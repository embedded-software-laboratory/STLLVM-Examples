; ModuleID = 'smooth'
source_filename = "./bench/smooth.st"

%smooth.state = type { [10 x i16], [10 x i16] }

@in_data = private unnamed_addr constant [8 x i8] c"in_data\00", align 1

define void @smooth.init(%smooth.state* %state) {
entry:
  %state.in_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 0
  br label %array_init_loop

array_init_loop:                                  ; preds = %array_init_inc, %entry
  %0 = phi i64 [ 0, %entry ], [ %2, %array_init_inc ]
  %1 = getelementptr [10 x i16], [10 x i16]* %state.in_data, i64 0, i64 %0
  store i16 0, i16* %1, align 2
  br label %array_init_inc

array_init_inc:                                   ; preds = %array_init_loop
  %2 = add i64 %0, 1
  %3 = icmp ult i64 %2, 10
  br i1 %3, label %array_init_loop, label %array_init_end

array_init_end:                                   ; preds = %array_init_inc
  %state.out_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 1
  br label %array_init_loop1

array_init_loop1:                                 ; preds = %array_init_inc2, %array_init_end
  %4 = phi i64 [ 0, %array_init_end ], [ %6, %array_init_inc2 ]
  %5 = getelementptr [10 x i16], [10 x i16]* %state.out_data, i64 0, i64 %4
  store i16 0, i16* %5, align 2
  br label %array_init_inc2

array_init_inc2:                                  ; preds = %array_init_loop1
  %6 = add i64 %4, 1
  %7 = icmp ult i64 %6, 10
  br i1 %7, label %array_init_loop1, label %array_init_end3

array_init_end3:                                  ; preds = %array_init_inc2
  ret void
}

define void @smooth(%smooth.state* %state) !dbg !3 {
entry:
  %state.in_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 0
  %state.out_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 1
  %i = alloca i16, align 2
  store i16 0, i16* %i, align 2
  %j = alloca i16, align 2
  store i16 0, i16* %j, align 2
  %val = alloca i16, align 2
  store i16 0, i16* %val, align 2
  store i16 1, i16* %i, align 2, !dbg !7
  br label %for_header, !dbg !7

for_header:                                       ; preds = %for_inc13, %entry
  %i.value = load i16, i16* %i, align 2, !dbg !7
  %0 = icmp sle i16 %i.value, 10, !dbg !7
  br i1 %0, label %for_body, label %for_end15, !dbg !7

for_body:                                         ; preds = %for_header
  store i16 0, i16* %val, align 2, !dbg !8
  %i.value1 = load i16, i16* %i, align 2, !dbg !9
  %1 = sub i16 %i.value1, 1, !dbg !9
  store i16 %1, i16* %j, align 2, !dbg !9
  br label %for_header2, !dbg !9

for_header2:                                      ; preds = %for_inc, %for_body
  %j.value = load i16, i16* %j, align 2, !dbg !9
  %i.value3 = load i16, i16* %i, align 2, !dbg !9
  %2 = add i16 %i.value3, 1, !dbg !9
  %3 = icmp sle i16 %j.value, %2, !dbg !9
  br i1 %3, label %for_body4, label %for_end, !dbg !9

for_body4:                                        ; preds = %for_header2
  %j.value5 = load i16, i16* %j, align 2, !dbg !10
  %4 = icmp sge i16 %j.value5, 1, !dbg !10
  %j.value6 = load i16, i16* %j, align 2, !dbg !10
  %5 = icmp sle i16 %j.value6, 10, !dbg !10
  %6 = and i1 %4, %5, !dbg !10
  br i1 %6, label %if_then, label %if_else, !dbg !10

if_then:                                          ; preds = %for_body4
  %val.value = load i16, i16* %val, align 2, !dbg !11
  %i.value7 = load i16, i16* %i, align 2, !dbg !11
  %7 = sub i16 %i.value7, 1, !dbg !11
  %8 = getelementptr [10 x i16], [10 x i16]* %state.in_data, i64 0, i16 %7, !dbg !11
  %.value = load i16, i16* %8, align 2, !dbg !11
  %i.value8 = load i16, i16* %i, align 2, !dbg !11
  %j.value9 = load i16, i16* %j, align 2, !dbg !11
  %9 = sub i16 %i.value8, %j.value9, !dbg !11
  %10 = call i16 @llvm.abs.i16(i16 %9, i1 false), !dbg !11
  %11 = sdiv i16 %.value, %10, !dbg !11
  %12 = add i16 %val.value, %11, !dbg !11
  store i16 %12, i16* %val, align 2, !dbg !11
  br label %if_merge, !dbg !11

if_else:                                          ; preds = %for_body4
  br label %if_merge, !dbg !11

if_merge:                                         ; preds = %if_else, %if_then
  br label %for_inc, !dbg !11

for_inc:                                          ; preds = %if_merge
  %j.value10 = load i16, i16* %j, align 2, !dbg !11
  %13 = add i16 %j.value10, 1, !dbg !11
  store i16 %13, i16* %j, align 2, !dbg !11
  br label %for_header2, !dbg !11

for_end:                                          ; preds = %for_header2
  %i.value11 = load i16, i16* %i, align 2, !dbg !12
  %14 = sub i16 %i.value11, 1, !dbg !12
  %15 = getelementptr [10 x i16], [10 x i16]* %state.out_data, i64 0, i16 %14, !dbg !12
  %val.value12 = load i16, i16* %val, align 2, !dbg !12
  %16 = sdiv i16 %val.value12, 2, !dbg !12
  store i16 %16, i16* %15, align 2, !dbg !12
  br label %for_inc13, !dbg !12

for_inc13:                                        ; preds = %for_end
  %i.value14 = load i16, i16* %i, align 2, !dbg !12
  %17 = add i16 %i.value14, 1, !dbg !12
  store i16 %17, i16* %i, align 2, !dbg !12
  br label %for_header, !dbg !12

for_end15:                                        ; preds = %for_header
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.abs.i16(i16, i1 immarg) #0

declare void @klee_make_symbolic(i8*, i64, i8*)

define void @main() {
entry:
  %0 = alloca [10 x i16], align 2
  %1 = bitcast [10 x i16]* %0 to i8*
  call void @klee_make_symbolic(i8* %1, i64 20, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @in_data, i32 0, i32 0))
  call void @smooth_wrapper([10 x i16]* %0)
  ret void
}

define void @smooth_wrapper([10 x i16]* %0) {
entry:
  %state = alloca %smooth.state, align 8
  call void @smooth.init(%smooth.state* %state)
  %1 = load [10 x i16], [10 x i16]* %0, align 2
  %in_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 0
  store [10 x i16] %1, [10 x i16]* %in_data, align 2
  call void @smooth(%smooth.state* %state)
  ret void
}

attributes #0 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_Pascal83, file: !2, producer: "stllvm", isOptimized: false, runtimeVersion: 1, emissionKind: FullDebug)
!2 = !DIFile(filename: "./bench/smooth.st", directory: ".")
!3 = distinct !DISubprogram(name: "smooth", linkageName: "smooth", scope: null, file: !2, line: 1, type: !4, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1, retainedNodes: !6)
!4 = !DISubroutineType(types: !5)
!5 = !{null}
!6 = !{}
!7 = !DILocation(line: 6, column: 1, scope: !3)
!8 = !DILocation(line: 7, column: 3, scope: !3)
!9 = !DILocation(line: 8, column: 3, scope: !3)
!10 = !DILocation(line: 9, column: 5, scope: !3)
!11 = !DILocation(line: 10, column: 7, scope: !3)
!12 = !DILocation(line: 13, column: 3, scope: !3)
