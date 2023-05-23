; ModuleID = 'buffer'
source_filename = "./bench/buffer.st"

%buffer.state = type { i16, i16, i16 }

@buf = global [1025 x i16] zeroinitializer
@value = private unnamed_addr constant [6 x i8] c"value\00", align 1
@offset = private unnamed_addr constant [7 x i8] c"offset\00", align 1
@cur_pos = private unnamed_addr constant [8 x i8] c"cur_pos\00", align 1

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
  %5 = getelementptr [1025 x i16], [1025 x i16]* @buf, i64 0, i16 %4, !dbg !12
  %state.value.value = load i16, i16* %state.value, align 2, !dbg !12
  store i16 %state.value.value, i16* %5, align 2, !dbg !12
  ret void
}

declare void @klee_make_symbolic(i8*, i64, i8*)

define void @main() {
entry:
  %0 = alloca i16, align 2
  %1 = bitcast i16* %0 to i8*
  call void @klee_make_symbolic(i8* %1, i64 2, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @value, i32 0, i32 0))
  %2 = alloca i16, align 2
  %3 = bitcast i16* %2 to i8*
  call void @klee_make_symbolic(i8* %3, i64 2, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @offset, i32 0, i32 0))
  %4 = alloca i16, align 2
  %5 = bitcast i16* %4 to i8*
  call void @klee_make_symbolic(i8* %5, i64 2, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @cur_pos, i32 0, i32 0))
  call void @buffer_wrapper(i16* %0, i16* %2, i16* %4)
  ret void
}

define void @buffer_wrapper(i16* %0, i16* %1, i16* %2) {
entry:
  %state = alloca %buffer.state, align 8
  call void @buffer.init(%buffer.state* %state)
  %3 = load i16, i16* %0, align 2
  %value = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 0
  store i16 %3, i16* %value, align 2
  %4 = load i16, i16* %1, align 2
  %offset = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 1
  store i16 %4, i16* %offset, align 2
  %5 = load i16, i16* %2, align 2
  %cur_pos = getelementptr %buffer.state, %buffer.state* %state, i32 0, i32 2
  store i16 %5, i16* %cur_pos, align 2
  call void @buffer(%buffer.state* %state)
  ret void
}

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
