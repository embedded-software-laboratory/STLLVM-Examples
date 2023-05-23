; ModuleID = 'smooth'
source_filename = "./bench/smooth.st"

%smooth.state = type { [10 x i16], [10 x i16] }

define void @smooth.init(%smooth.state* %state) {
entry:
  %state.in_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 0
  %0 = call [10 x i16] @nondet_value_for_in_data()
  store [10 x i16] %0, [10 x i16]* %state.in_data, align 2
  %state.out_data = getelementptr %smooth.state, %smooth.state* %state, i32 0, i32 1
  %1 = call [10 x i16] @nondet_value_for_out_data()
  store [10 x i16] %1, [10 x i16]* %state.out_data, align 2
  ret void
}

declare [10 x i16] @nondet_value_for_in_data()

declare [10 x i16] @nondet_value_for_out_data()

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

for_header:                                       ; preds = %for_inc15, %entry
  %i.value = load i16, i16* %i, align 2, !dbg !7
  %0 = icmp sle i16 %i.value, 10, !dbg !7
  br i1 %0, label %for_body, label %for_end17, !dbg !7

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
  %8 = icmp sge i16 %i.value7, 1, !dbg !11
  %9 = icmp sle i16 %i.value7, 10, !dbg !11
  %10 = and i1 %8, %9, !dbg !11
  br i1 %10, label %subrange_valid, label %__VERIFIER_error_block, !dbg !11

__VERIFIER_error_block:                           ; preds = %subrange_valid12, %for_end, %subrange_valid, %if_then
  call void @__VERIFIER_error(), !dbg !11
  unreachable, !dbg !11

subrange_valid:                                   ; preds = %if_then
  %11 = getelementptr [10 x i16], [10 x i16]* %state.in_data, i64 0, i16 %7, !dbg !11
  %.value = load i16, i16* %11, align 2, !dbg !11
  %i.value8 = load i16, i16* %i, align 2, !dbg !11
  %j.value9 = load i16, i16* %j, align 2, !dbg !11
  %12 = sub i16 %i.value8, %j.value9, !dbg !11
  %13 = call i16 @llvm.abs.i16(i16 %12, i1 false), !dbg !11
  %14 = icmp eq i16 %13, 0, !dbg !11
  br i1 %14, label %__VERIFIER_error_block, label %non_zero_division, !dbg !11

non_zero_division:                                ; preds = %subrange_valid
  %15 = sdiv i16 %.value, %13, !dbg !11
  %16 = add i16 %val.value, %15, !dbg !11
  store i16 %16, i16* %val, align 2, !dbg !11
  br label %if_merge, !dbg !11

if_else:                                          ; preds = %for_body4
  br label %if_merge, !dbg !11

if_merge:                                         ; preds = %if_else, %non_zero_division
  br label %for_inc, !dbg !11

for_inc:                                          ; preds = %if_merge
  %j.value10 = load i16, i16* %j, align 2, !dbg !11
  %17 = add i16 %j.value10, 1, !dbg !11
  store i16 %17, i16* %j, align 2, !dbg !11
  br label %for_header2, !dbg !11

for_end:                                          ; preds = %for_header2
  %i.value11 = load i16, i16* %i, align 2, !dbg !12
  %18 = sub i16 %i.value11, 1, !dbg !12
  %19 = icmp sge i16 %i.value11, 1, !dbg !12
  %20 = icmp sle i16 %i.value11, 10, !dbg !12
  %21 = and i1 %19, %20, !dbg !12
  br i1 %21, label %subrange_valid12, label %__VERIFIER_error_block, !dbg !12

subrange_valid12:                                 ; preds = %for_end
  %22 = getelementptr [10 x i16], [10 x i16]* %state.out_data, i64 0, i16 %18, !dbg !12
  %val.value13 = load i16, i16* %val, align 2, !dbg !12
  br i1 false, label %__VERIFIER_error_block, label %non_zero_division14, !dbg !12

non_zero_division14:                              ; preds = %subrange_valid12
  %23 = sdiv i16 %val.value13, 2, !dbg !12
  store i16 %23, i16* %22, align 2, !dbg !12
  br label %for_inc15, !dbg !12

for_inc15:                                        ; preds = %non_zero_division14
  %i.value16 = load i16, i16* %i, align 2, !dbg !12
  %24 = add i16 %i.value16, 1, !dbg !12
  store i16 %24, i16* %i, align 2, !dbg !12
  br label %for_header, !dbg !12

for_end17:                                        ; preds = %for_header
  ret void
}

declare void @__VERIFIER_error()

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.abs.i16(i16, i1 immarg) #0

define void @main() {
entry:
  %state = alloca %smooth.state, align 8
  call void @smooth.init(%smooth.state* %state)
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
