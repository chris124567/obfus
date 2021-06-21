; ModuleID = 'test/test.c'
source_filename = "test/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@testArray = internal unnamed_addr constant [7 x [2 x i32]] [[2 x i32] [i32 -5, i32 -6], [2 x i32] zeroinitializer, [2 x i32] [i32 1, i32 -6], [2 x i32] [i32 1, i32 1], [2 x i32] [i32 1, i32 2], [2 x i32] [i32 3, i32 4], [2 x i32] [i32 2147483640, i32 7]], align 16, !dbg !0
@testArrayAdd = internal unnamed_addr constant [7 x i32] [i32 -11, i32 0, i32 -5, i32 2, i32 3, i32 7, i32 2147483647], align 16, !dbg !6
@.str = private unnamed_addr constant [25 x i8] c"EXPECT_EQ: %s: %d != %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"add\00", align 1
@testArraySub = internal unnamed_addr constant [7 x i32] [i32 1, i32 0, i32 7, i32 0, i32 -1, i32 -1, i32 2147483633], align 16, !dbg !13
@.str.2 = private unnamed_addr constant [4 x i8] c"sub\00", align 1
@testArrayMul = internal unnamed_addr constant [7 x i32] [i32 30, i32 0, i32 -6, i32 1, i32 2, i32 12, i32 2147483592], align 16, !dbg !15
@.str.3 = private unnamed_addr constant [4 x i8] c"mul\00", align 1
@testArrayXor = internal unnamed_addr constant [7 x i32] [i32 1, i32 0, i32 -5, i32 0, i32 3, i32 7, i32 2147483647], align 16, !dbg !17
@.str.4 = private unnamed_addr constant [4 x i8] c"xor\00", align 1
@testArrayOr = internal unnamed_addr constant [7 x i32] [i32 -5, i32 0, i32 -5, i32 1, i32 3, i32 7, i32 2147483647], align 16, !dbg !19
@.str.5 = private unnamed_addr constant [3 x i8] c"or\00", align 1
@testArrayAnd = internal unnamed_addr constant [7 x i32] [i32 -6, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0], align 16, !dbg !21
@.str.6 = private unnamed_addr constant [4 x i8] c"and\00", align 1
@.str.7 = private unnamed_addr constant [13 x i8] c"password(-2)\00", align 1
@.str.8 = private unnamed_addr constant [13 x i8] c"password(-1)\00", align 1
@.str.9 = private unnamed_addr constant [12 x i8] c"password(0)\00", align 1
@.str.10 = private unnamed_addr constant [12 x i8] c"password(1)\00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"password(2)\00", align 1
@.str.12 = private unnamed_addr constant [12 x i8] c"password(3)\00", align 1
@.str.13 = private unnamed_addr constant [12 x i8] c"password(4)\00", align 1
@.str.14 = private unnamed_addr constant [15 x i8] c"password(5000)\00", align 1
@.str.15 = private unnamed_addr constant [13 x i8] c"password8(0)\00", align 1
@.str.16 = private unnamed_addr constant [13 x i8] c"password8(1)\00", align 1
@.str.17 = private unnamed_addr constant [13 x i8] c"password8(2)\00", align 1
@.str.18 = private unnamed_addr constant [13 x i8] c"password8(3)\00", align 1
@.str.19 = private unnamed_addr constant [13 x i8] c"password8(4)\00", align 1
@str = private unnamed_addr constant [16 x i8] c"Finished tests!\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !30 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !34, metadata !DIExpression()), !dbg !40
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !35, metadata !DIExpression()), !dbg !41
  %5 = load i32, i32* %3, align 4, !dbg !42, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !43, !tbaa !36
  %7 = add nsw i32 %5, %6, !dbg !44
  ret i32 %7, !dbg !45
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sub(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !46 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !48, metadata !DIExpression()), !dbg !50
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !49, metadata !DIExpression()), !dbg !51
  %5 = load i32, i32* %3, align 4, !dbg !52, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !53, !tbaa !36
  %7 = sub nsw i32 %5, %6, !dbg !54
  ret i32 %7, !dbg !55
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @mul(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !56 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !58, metadata !DIExpression()), !dbg !60
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !59, metadata !DIExpression()), !dbg !61
  %5 = load i32, i32* %3, align 4, !dbg !62, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !63, !tbaa !36
  %7 = mul nsw i32 %5, %6, !dbg !64
  ret i32 %7, !dbg !65
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xor1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !66 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !68, metadata !DIExpression()), !dbg !70
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !69, metadata !DIExpression()), !dbg !71
  %5 = load i32, i32* %3, align 4, !dbg !72, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !73, !tbaa !36
  %7 = xor i32 %5, %6, !dbg !74
  ret i32 %7, !dbg !75
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @or1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !76 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !78, metadata !DIExpression()), !dbg !80
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !79, metadata !DIExpression()), !dbg !81
  %5 = load i32, i32* %3, align 4, !dbg !82, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !83, !tbaa !36
  %7 = or i32 %5, %6, !dbg !84
  ret i32 %7, !dbg !85
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @and1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !86 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !88, metadata !DIExpression()), !dbg !90
  store i32 %1, i32* %4, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %4, metadata !89, metadata !DIExpression()), !dbg !91
  %5 = load i32, i32* %3, align 4, !dbg !92, !tbaa !36
  %6 = load i32, i32* %4, align 4, !dbg !93, !tbaa !36
  %7 = and i32 %5, %6, !dbg !94
  ret i32 %7, !dbg !95
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @password(i32 %0) local_unnamed_addr #0 !dbg !96 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !36
  call void @llvm.dbg.declare(metadata i32* %3, metadata !100, metadata !DIExpression()), !dbg !101
  %4 = load i32, i32* %3, align 4, !dbg !102, !tbaa !36
  %5 = icmp sge i32 %4, 0, !dbg !104
  br i1 %5, label %6, label %14, !dbg !105

6:                                                ; preds = %1
  %7 = load i32, i32* %3, align 4, !dbg !106, !tbaa !36
  %8 = icmp slt i32 %7, 5, !dbg !107
  br i1 %8, label %9, label %14, !dbg !108

9:                                                ; preds = %6
  %10 = load i32, i32* %3, align 4, !dbg !109, !tbaa !36
  %11 = and i32 %10, 1, !dbg !110
  %12 = icmp eq i32 %11, 0, !dbg !111
  br i1 %12, label %13, label %14, !dbg !112

13:                                               ; preds = %9
  store i32 1337, i32* %2, align 4, !dbg !113
  br label %15, !dbg !113

14:                                               ; preds = %9, %6, %1
  store i32 -1, i32* %2, align 4, !dbg !115
  br label %15, !dbg !115

15:                                               ; preds = %14, %13
  %16 = load i32, i32* %2, align 4, !dbg !117
  ret i32 %16, !dbg !117
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @password8(i8 zeroext %0) local_unnamed_addr #0 !dbg !118 {
  %2 = alloca i8, align 1
  %3 = alloca i8, align 1
  store i8 %0, i8* %3, align 1, !tbaa !129
  call void @llvm.dbg.declare(metadata i8* %3, metadata !128, metadata !DIExpression()), !dbg !130
  %4 = load i8, i8* %3, align 1, !dbg !131, !tbaa !129
  %5 = zext i8 %4 to i32, !dbg !131
  %6 = icmp sge i32 %5, 0, !dbg !133
  br i1 %6, label %7, label %17, !dbg !134

7:                                                ; preds = %1
  %8 = load i8, i8* %3, align 1, !dbg !135, !tbaa !129
  %9 = zext i8 %8 to i32, !dbg !135
  %10 = icmp slt i32 %9, 5, !dbg !136
  br i1 %10, label %11, label %17, !dbg !137

11:                                               ; preds = %7
  %12 = load i8, i8* %3, align 1, !dbg !138, !tbaa !129
  %13 = zext i8 %12 to i32, !dbg !138
  %14 = and i32 %13, 1, !dbg !139
  %15 = icmp eq i32 %14, 0, !dbg !140
  br i1 %15, label %16, label %17, !dbg !141

16:                                               ; preds = %11
  store i8 111, i8* %2, align 1, !dbg !142
  br label %18, !dbg !142

17:                                               ; preds = %11, %7, %1
  store i8 0, i8* %2, align 1, !dbg !144
  br label %18, !dbg !144

18:                                               ; preds = %17, %16
  %19 = load i8, i8* %2, align 1, !dbg !146
  ret i8 %19, !dbg !146
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @return5000() local_unnamed_addr #0 !dbg !147 {
  ret i32 5000, !dbg !150
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 !dbg !151 {
  call void @llvm.dbg.value(metadata i32 0, metadata !153, metadata !DIExpression()), !dbg !160
  br label %1, !dbg !161

1:                                                ; preds = %54, %0
  %2 = phi i64 [ 0, %0 ], [ %55, %54 ]
  call void @llvm.dbg.value(metadata i64 %2, metadata !153, metadata !DIExpression()), !dbg !160
  %3 = getelementptr inbounds [7 x [2 x i32]], [7 x [2 x i32]]* @testArray, i64 0, i64 %2, i64 0, !dbg !162
  %4 = load i32, i32* %3, align 8, !dbg !162, !tbaa !36
  call void @llvm.dbg.value(metadata i32 %4, metadata !155, metadata !DIExpression()), !dbg !163
  %5 = getelementptr inbounds [7 x [2 x i32]], [7 x [2 x i32]]* @testArray, i64 0, i64 %2, i64 1, !dbg !164
  %6 = load i32, i32* %5, align 4, !dbg !164, !tbaa !36
  call void @llvm.dbg.value(metadata i32 %6, metadata !159, metadata !DIExpression()), !dbg !163
  %7 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayAdd, i64 0, i64 %2, !dbg !165
  %8 = load i32, i32* %7, align 4, !dbg !165, !tbaa !36
  %9 = tail call i32 @add(i32 %4, i32 %6), !dbg !165
  %10 = icmp eq i32 %8, %9, !dbg !165
  br i1 %10, label %14, label %11, !dbg !165

11:                                               ; preds = %1
  %12 = tail call i32 @add(i32 %4, i32 %6), !dbg !165
  %13 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 %8, i32 %12), !dbg !165
  br label %14, !dbg !165

14:                                               ; preds = %1, %11
  %15 = getelementptr inbounds [7 x i32], [7 x i32]* @testArraySub, i64 0, i64 %2, !dbg !166
  %16 = load i32, i32* %15, align 4, !dbg !166, !tbaa !36
  %17 = tail call i32 @sub(i32 %4, i32 %6), !dbg !166
  %18 = icmp eq i32 %16, %17, !dbg !166
  br i1 %18, label %22, label %19, !dbg !166

19:                                               ; preds = %14
  %20 = tail call i32 @sub(i32 %4, i32 %6), !dbg !166
  %21 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0), i32 %16, i32 %20), !dbg !166
  br label %22, !dbg !166

22:                                               ; preds = %14, %19
  %23 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayMul, i64 0, i64 %2, !dbg !167
  %24 = load i32, i32* %23, align 4, !dbg !167, !tbaa !36
  %25 = tail call i32 @mul(i32 %4, i32 %6), !dbg !167
  %26 = icmp eq i32 %24, %25, !dbg !167
  br i1 %26, label %30, label %27, !dbg !167

27:                                               ; preds = %22
  %28 = tail call i32 @mul(i32 %4, i32 %6), !dbg !167
  %29 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 %24, i32 %28), !dbg !167
  br label %30, !dbg !167

30:                                               ; preds = %22, %27
  %31 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayXor, i64 0, i64 %2, !dbg !168
  %32 = load i32, i32* %31, align 4, !dbg !168, !tbaa !36
  %33 = tail call i32 @xor1(i32 %4, i32 %6), !dbg !168
  %34 = icmp eq i32 %32, %33, !dbg !168
  br i1 %34, label %38, label %35, !dbg !168

35:                                               ; preds = %30
  %36 = tail call i32 @xor1(i32 %4, i32 %6), !dbg !168
  %37 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i64 0, i64 0), i32 %32, i32 %36), !dbg !168
  br label %38, !dbg !168

38:                                               ; preds = %30, %35
  %39 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayOr, i64 0, i64 %2, !dbg !169
  %40 = load i32, i32* %39, align 4, !dbg !169, !tbaa !36
  %41 = tail call i32 @or1(i32 %4, i32 %6), !dbg !169
  %42 = icmp eq i32 %40, %41, !dbg !169
  br i1 %42, label %46, label %43, !dbg !169

43:                                               ; preds = %38
  %44 = tail call i32 @or1(i32 %4, i32 %6), !dbg !169
  %45 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i64 0, i64 0), i32 %40, i32 %44), !dbg !169
  br label %46, !dbg !169

46:                                               ; preds = %38, %43
  %47 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayAnd, i64 0, i64 %2, !dbg !170
  %48 = load i32, i32* %47, align 4, !dbg !170, !tbaa !36
  %49 = tail call i32 @and1(i32 %4, i32 %6), !dbg !170
  %50 = icmp eq i32 %48, %49, !dbg !170
  br i1 %50, label %54, label %51, !dbg !170

51:                                               ; preds = %46
  %52 = tail call i32 @and1(i32 %4, i32 %6), !dbg !170
  %53 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i64 0, i64 0), i32 %48, i32 %52), !dbg !170
  br label %54, !dbg !170

54:                                               ; preds = %46, %51
  %55 = add nuw nsw i64 %2, 1, !dbg !171
  call void @llvm.dbg.value(metadata i64 %55, metadata !153, metadata !DIExpression()), !dbg !160
  %56 = icmp eq i64 %55, 7, !dbg !172
  br i1 %56, label %57, label %1, !dbg !161, !llvm.loop !173

57:                                               ; preds = %54
  %58 = tail call i32 @password(i32 -2), !dbg !175
  %59 = icmp eq i32 %58, -1, !dbg !175
  br i1 %59, label %63, label %60, !dbg !175

60:                                               ; preds = %57
  %61 = tail call i32 @password(i32 -2), !dbg !175
  %62 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.7, i64 0, i64 0), i32 %61, i32 -1), !dbg !175
  br label %63, !dbg !175

63:                                               ; preds = %57, %60
  %64 = tail call i32 @password(i32 -1), !dbg !176
  %65 = icmp eq i32 %64, -1, !dbg !176
  br i1 %65, label %69, label %66, !dbg !176

66:                                               ; preds = %63
  %67 = tail call i32 @password(i32 -1), !dbg !176
  %68 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.8, i64 0, i64 0), i32 %67, i32 -1), !dbg !176
  br label %69, !dbg !176

69:                                               ; preds = %63, %66
  %70 = tail call i32 @password(i32 0), !dbg !177
  %71 = icmp eq i32 %70, 1337, !dbg !177
  br i1 %71, label %75, label %72, !dbg !177

72:                                               ; preds = %69
  %73 = tail call i32 @password(i32 0), !dbg !177
  %74 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.9, i64 0, i64 0), i32 %73, i32 1337), !dbg !177
  br label %75, !dbg !177

75:                                               ; preds = %69, %72
  %76 = tail call i32 @password(i32 1), !dbg !178
  %77 = icmp eq i32 %76, -1, !dbg !178
  br i1 %77, label %81, label %78, !dbg !178

78:                                               ; preds = %75
  %79 = tail call i32 @password(i32 1), !dbg !178
  %80 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.10, i64 0, i64 0), i32 %79, i32 -1), !dbg !178
  br label %81, !dbg !178

81:                                               ; preds = %75, %78
  %82 = tail call i32 @password(i32 2), !dbg !179
  %83 = icmp eq i32 %82, 1337, !dbg !179
  br i1 %83, label %87, label %84, !dbg !179

84:                                               ; preds = %81
  %85 = tail call i32 @password(i32 2), !dbg !179
  %86 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i64 0, i64 0), i32 %85, i32 1337), !dbg !179
  br label %87, !dbg !179

87:                                               ; preds = %81, %84
  %88 = tail call i32 @password(i32 3), !dbg !180
  %89 = icmp eq i32 %88, -1, !dbg !180
  br i1 %89, label %93, label %90, !dbg !180

90:                                               ; preds = %87
  %91 = tail call i32 @password(i32 3), !dbg !180
  %92 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.12, i64 0, i64 0), i32 %91, i32 -1), !dbg !180
  br label %93, !dbg !180

93:                                               ; preds = %87, %90
  %94 = tail call i32 @password(i32 4), !dbg !181
  %95 = icmp eq i32 %94, 1337, !dbg !181
  br i1 %95, label %99, label %96, !dbg !181

96:                                               ; preds = %93
  %97 = tail call i32 @password(i32 4), !dbg !181
  %98 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.13, i64 0, i64 0), i32 %97, i32 1337), !dbg !181
  br label %99, !dbg !181

99:                                               ; preds = %93, %96
  %100 = tail call i32 @password(i32 5000), !dbg !182
  %101 = icmp eq i32 %100, -1, !dbg !182
  br i1 %101, label %105, label %102, !dbg !182

102:                                              ; preds = %99
  %103 = tail call i32 @password(i32 5000), !dbg !182
  %104 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.14, i64 0, i64 0), i32 %103, i32 -1), !dbg !182
  br label %105, !dbg !182

105:                                              ; preds = %99, %102
  %106 = tail call zeroext i8 @password8(i8 zeroext 0), !dbg !183
  %107 = icmp eq i8 %106, 111, !dbg !183
  br i1 %107, label %112, label %108, !dbg !183

108:                                              ; preds = %105
  %109 = tail call zeroext i8 @password8(i8 zeroext 0), !dbg !183
  %110 = zext i8 %109 to i32, !dbg !183
  %111 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.15, i64 0, i64 0), i32 %110, i32 111), !dbg !183
  br label %112, !dbg !183

112:                                              ; preds = %105, %108
  %113 = tail call zeroext i8 @password8(i8 zeroext 1), !dbg !184
  %114 = icmp eq i8 %113, 0, !dbg !184
  br i1 %114, label %119, label %115, !dbg !184

115:                                              ; preds = %112
  %116 = tail call zeroext i8 @password8(i8 zeroext 1), !dbg !184
  %117 = zext i8 %116 to i32, !dbg !184
  %118 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.16, i64 0, i64 0), i32 %117, i32 0), !dbg !184
  br label %119, !dbg !184

119:                                              ; preds = %112, %115
  %120 = tail call zeroext i8 @password8(i8 zeroext 2), !dbg !185
  %121 = icmp eq i8 %120, 111, !dbg !185
  br i1 %121, label %126, label %122, !dbg !185

122:                                              ; preds = %119
  %123 = tail call zeroext i8 @password8(i8 zeroext 2), !dbg !185
  %124 = zext i8 %123 to i32, !dbg !185
  %125 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.17, i64 0, i64 0), i32 %124, i32 111), !dbg !185
  br label %126, !dbg !185

126:                                              ; preds = %119, %122
  %127 = tail call zeroext i8 @password8(i8 zeroext 3), !dbg !186
  %128 = icmp eq i8 %127, 0, !dbg !186
  br i1 %128, label %133, label %129, !dbg !186

129:                                              ; preds = %126
  %130 = tail call zeroext i8 @password8(i8 zeroext 3), !dbg !186
  %131 = zext i8 %130 to i32, !dbg !186
  %132 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.18, i64 0, i64 0), i32 %131, i32 0), !dbg !186
  br label %133, !dbg !186

133:                                              ; preds = %126, %129
  %134 = tail call zeroext i8 @password8(i8 zeroext 4), !dbg !187
  %135 = icmp eq i8 %134, 111, !dbg !187
  br i1 %135, label %140, label %136, !dbg !187

136:                                              ; preds = %133
  %137 = tail call zeroext i8 @password8(i8 zeroext 4), !dbg !187
  %138 = zext i8 %137 to i32, !dbg !187
  %139 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.19, i64 0, i64 0), i32 %138, i32 111), !dbg !187
  br label %140, !dbg !187

140:                                              ; preds = %133, %136
  %141 = tail call i32 @return5000(), !dbg !188
  %142 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @str, i64 0, i64 0)), !dbg !189
  ret i32 0, !dbg !190
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="broadwell" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt,-amx-bf16,-amx-int8,-amx-tile,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clflushopt,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-rtm,-serialize,-sgx,-sha,-shstk,-sse4a,-tbm,-tsxldtrk,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop,-xsavec,-xsaves" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="broadwell" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt,-amx-bf16,-amx-int8,-amx-tile,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clflushopt,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-rtm,-serialize,-sgx,-sha,-shstk,-sse4a,-tbm,-tsxldtrk,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop,-xsavec,-xsaves" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #3 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="broadwell" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt,-amx-bf16,-amx-int8,-amx-tile,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clflushopt,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-rtm,-serialize,-sgx,-sha,-shstk,-sse4a,-tbm,-tsxldtrk,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop,-xsavec,-xsaves" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #4 = { nofree nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!26, !27, !28}
!llvm.ident = !{!29}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "testArray", scope: !2, file: !3, line: 53, type: !23, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C89, file: !3, producer: "Debian clang version 11.1.0-++20210428103820+1fdec59bffc1-1~exp1~20210428204437.162", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test/test.c", directory: "/home/christopher/prog/cpp/obfus")
!4 = !{}
!5 = !{!0, !6, !13, !15, !17, !19, !21}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "testArrayAdd", scope: !2, file: !3, line: 54, type: !8, isLocal: true, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 224, elements: !11)
!9 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!12}
!12 = !DISubrange(count: 7)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "testArraySub", scope: !2, file: !3, line: 55, type: !8, isLocal: true, isDefinition: true)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "testArrayMul", scope: !2, file: !3, line: 56, type: !8, isLocal: true, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "testArrayXor", scope: !2, file: !3, line: 57, type: !8, isLocal: true, isDefinition: true)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(name: "testArrayOr", scope: !2, file: !3, line: 58, type: !8, isLocal: true, isDefinition: true)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "testArrayAnd", scope: !2, file: !3, line: 59, type: !8, isLocal: true, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 448, elements: !24)
!24 = !{!12, !25}
!25 = !DISubrange(count: 2)
!26 = !{i32 7, !"Dwarf Version", i32 4}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = !{!"Debian clang version 11.1.0-++20210428103820+1fdec59bffc1-1~exp1~20210428204437.162"}
!30 = distinct !DISubprogram(name: "add", scope: !3, file: !3, line: 5, type: !31, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !33)
!31 = !DISubroutineType(types: !32)
!32 = !{!10, !9, !9}
!33 = !{!34, !35}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !30, file: !3, line: 5, type: !9)
!35 = !DILocalVariable(name: "y", arg: 2, scope: !30, file: !3, line: 5, type: !9)
!36 = !{!37, !37, i64 0}
!37 = !{!"int", !38, i64 0}
!38 = !{!"omnipotent char", !39, i64 0}
!39 = !{!"Simple C/C++ TBAA"}
!40 = !DILocation(line: 5, column: 44, scope: !30)
!41 = !DILocation(line: 5, column: 57, scope: !30)
!42 = !DILocation(line: 6, column: 12, scope: !30)
!43 = !DILocation(line: 6, column: 16, scope: !30)
!44 = !DILocation(line: 6, column: 14, scope: !30)
!45 = !DILocation(line: 6, column: 5, scope: !30)
!46 = distinct !DISubprogram(name: "sub", scope: !3, file: !3, line: 9, type: !31, scopeLine: 9, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !47)
!47 = !{!48, !49}
!48 = !DILocalVariable(name: "x", arg: 1, scope: !46, file: !3, line: 9, type: !9)
!49 = !DILocalVariable(name: "y", arg: 2, scope: !46, file: !3, line: 9, type: !9)
!50 = !DILocation(line: 9, column: 44, scope: !46)
!51 = !DILocation(line: 9, column: 57, scope: !46)
!52 = !DILocation(line: 10, column: 12, scope: !46)
!53 = !DILocation(line: 10, column: 16, scope: !46)
!54 = !DILocation(line: 10, column: 14, scope: !46)
!55 = !DILocation(line: 10, column: 5, scope: !46)
!56 = distinct !DISubprogram(name: "mul", scope: !3, file: !3, line: 13, type: !31, scopeLine: 13, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !57)
!57 = !{!58, !59}
!58 = !DILocalVariable(name: "x", arg: 1, scope: !56, file: !3, line: 13, type: !9)
!59 = !DILocalVariable(name: "y", arg: 2, scope: !56, file: !3, line: 13, type: !9)
!60 = !DILocation(line: 13, column: 44, scope: !56)
!61 = !DILocation(line: 13, column: 57, scope: !56)
!62 = !DILocation(line: 14, column: 12, scope: !56)
!63 = !DILocation(line: 14, column: 16, scope: !56)
!64 = !DILocation(line: 14, column: 14, scope: !56)
!65 = !DILocation(line: 14, column: 5, scope: !56)
!66 = distinct !DISubprogram(name: "xor1", scope: !3, file: !3, line: 20, type: !31, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !67)
!67 = !{!68, !69}
!68 = !DILocalVariable(name: "x", arg: 1, scope: !66, file: !3, line: 20, type: !9)
!69 = !DILocalVariable(name: "y", arg: 2, scope: !66, file: !3, line: 20, type: !9)
!70 = !DILocation(line: 20, column: 45, scope: !66)
!71 = !DILocation(line: 20, column: 58, scope: !66)
!72 = !DILocation(line: 21, column: 12, scope: !66)
!73 = !DILocation(line: 21, column: 16, scope: !66)
!74 = !DILocation(line: 21, column: 14, scope: !66)
!75 = !DILocation(line: 21, column: 5, scope: !66)
!76 = distinct !DISubprogram(name: "or1", scope: !3, file: !3, line: 24, type: !31, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !77)
!77 = !{!78, !79}
!78 = !DILocalVariable(name: "x", arg: 1, scope: !76, file: !3, line: 24, type: !9)
!79 = !DILocalVariable(name: "y", arg: 2, scope: !76, file: !3, line: 24, type: !9)
!80 = !DILocation(line: 24, column: 44, scope: !76)
!81 = !DILocation(line: 24, column: 57, scope: !76)
!82 = !DILocation(line: 25, column: 12, scope: !76)
!83 = !DILocation(line: 25, column: 16, scope: !76)
!84 = !DILocation(line: 25, column: 14, scope: !76)
!85 = !DILocation(line: 25, column: 5, scope: !76)
!86 = distinct !DISubprogram(name: "and1", scope: !3, file: !3, line: 28, type: !31, scopeLine: 28, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !87)
!87 = !{!88, !89}
!88 = !DILocalVariable(name: "x", arg: 1, scope: !86, file: !3, line: 28, type: !9)
!89 = !DILocalVariable(name: "y", arg: 2, scope: !86, file: !3, line: 28, type: !9)
!90 = !DILocation(line: 28, column: 45, scope: !86)
!91 = !DILocation(line: 28, column: 58, scope: !86)
!92 = !DILocation(line: 29, column: 12, scope: !86)
!93 = !DILocation(line: 29, column: 16, scope: !86)
!94 = !DILocation(line: 29, column: 14, scope: !86)
!95 = !DILocation(line: 29, column: 5, scope: !86)
!96 = distinct !DISubprogram(name: "password", scope: !3, file: !3, line: 32, type: !97, scopeLine: 32, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !99)
!97 = !DISubroutineType(types: !98)
!98 = !{!10, !9}
!99 = !{!100}
!100 = !DILocalVariable(name: "input", arg: 1, scope: !96, file: !3, line: 32, type: !9)
!101 = !DILocation(line: 32, column: 49, scope: !96)
!102 = !DILocation(line: 33, column: 9, scope: !103)
!103 = distinct !DILexicalBlock(scope: !96, file: !3, line: 33, column: 9)
!104 = !DILocation(line: 33, column: 15, scope: !103)
!105 = !DILocation(line: 33, column: 20, scope: !103)
!106 = !DILocation(line: 33, column: 23, scope: !103)
!107 = !DILocation(line: 33, column: 29, scope: !103)
!108 = !DILocation(line: 33, column: 33, scope: !103)
!109 = !DILocation(line: 33, column: 37, scope: !103)
!110 = !DILocation(line: 33, column: 43, scope: !103)
!111 = !DILocation(line: 33, column: 48, scope: !103)
!112 = !DILocation(line: 33, column: 9, scope: !96)
!113 = !DILocation(line: 34, column: 9, scope: !114)
!114 = distinct !DILexicalBlock(scope: !103, file: !3, line: 33, column: 54)
!115 = !DILocation(line: 36, column: 9, scope: !116)
!116 = distinct !DILexicalBlock(scope: !103, file: !3, line: 35, column: 12)
!117 = !DILocation(line: 38, column: 1, scope: !96)
!118 = distinct !DISubprogram(name: "password8", scope: !3, file: !3, line: 40, type: !119, scopeLine: 40, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !127)
!119 = !DISubroutineType(types: !120)
!120 = !{!121, !126}
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !122, line: 24, baseType: !123)
!122 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!123 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !124, line: 37, baseType: !125)
!124 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!125 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!126 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !121)
!127 = !{!128}
!128 = !DILocalVariable(name: "input", arg: 1, scope: !118, file: !3, line: 40, type: !126)
!129 = !{!38, !38, i64 0}
!130 = !DILocation(line: 40, column: 58, scope: !118)
!131 = !DILocation(line: 41, column: 9, scope: !132)
!132 = distinct !DILexicalBlock(scope: !118, file: !3, line: 41, column: 9)
!133 = !DILocation(line: 41, column: 15, scope: !132)
!134 = !DILocation(line: 41, column: 20, scope: !132)
!135 = !DILocation(line: 41, column: 23, scope: !132)
!136 = !DILocation(line: 41, column: 29, scope: !132)
!137 = !DILocation(line: 41, column: 33, scope: !132)
!138 = !DILocation(line: 41, column: 37, scope: !132)
!139 = !DILocation(line: 41, column: 43, scope: !132)
!140 = !DILocation(line: 41, column: 48, scope: !132)
!141 = !DILocation(line: 41, column: 9, scope: !118)
!142 = !DILocation(line: 42, column: 9, scope: !143)
!143 = distinct !DILexicalBlock(scope: !132, file: !3, line: 41, column: 54)
!144 = !DILocation(line: 44, column: 9, scope: !145)
!145 = distinct !DILexicalBlock(scope: !132, file: !3, line: 43, column: 12)
!146 = !DILocation(line: 46, column: 1, scope: !118)
!147 = distinct !DISubprogram(name: "return5000", scope: !3, file: !3, line: 48, type: !148, scopeLine: 48, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!148 = !DISubroutineType(types: !149)
!149 = !{!10}
!150 = !DILocation(line: 49, column: 5, scope: !147)
!151 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 63, type: !148, scopeLine: 63, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !152)
!152 = !{!153, !155, !159}
!153 = !DILocalVariable(name: "i", scope: !151, file: !3, line: 64, type: !154)
!154 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!155 = !DILocalVariable(name: "x", scope: !156, file: !3, line: 66, type: !9)
!156 = distinct !DILexicalBlock(scope: !157, file: !3, line: 65, column: 68)
!157 = distinct !DILexicalBlock(scope: !158, file: !3, line: 65, column: 5)
!158 = distinct !DILexicalBlock(scope: !151, file: !3, line: 65, column: 5)
!159 = !DILocalVariable(name: "y", scope: !156, file: !3, line: 67, type: !9)
!160 = !DILocation(line: 0, scope: !151)
!161 = !DILocation(line: 65, column: 5, scope: !158)
!162 = !DILocation(line: 66, column: 23, scope: !156)
!163 = !DILocation(line: 0, scope: !156)
!164 = !DILocation(line: 67, column: 23, scope: !156)
!165 = !DILocation(line: 68, column: 9, scope: !156)
!166 = !DILocation(line: 69, column: 9, scope: !156)
!167 = !DILocation(line: 70, column: 9, scope: !156)
!168 = !DILocation(line: 71, column: 9, scope: !156)
!169 = !DILocation(line: 72, column: 9, scope: !156)
!170 = !DILocation(line: 73, column: 9, scope: !156)
!171 = !DILocation(line: 65, column: 64, scope: !157)
!172 = !DILocation(line: 65, column: 19, scope: !157)
!173 = distinct !{!173, !161, !174}
!174 = !DILocation(line: 74, column: 5, scope: !158)
!175 = !DILocation(line: 75, column: 5, scope: !151)
!176 = !DILocation(line: 76, column: 5, scope: !151)
!177 = !DILocation(line: 77, column: 5, scope: !151)
!178 = !DILocation(line: 78, column: 5, scope: !151)
!179 = !DILocation(line: 79, column: 5, scope: !151)
!180 = !DILocation(line: 80, column: 5, scope: !151)
!181 = !DILocation(line: 81, column: 5, scope: !151)
!182 = !DILocation(line: 82, column: 5, scope: !151)
!183 = !DILocation(line: 83, column: 5, scope: !151)
!184 = !DILocation(line: 84, column: 5, scope: !151)
!185 = !DILocation(line: 85, column: 5, scope: !151)
!186 = !DILocation(line: 86, column: 5, scope: !151)
!187 = !DILocation(line: 87, column: 5, scope: !151)
!188 = !DILocation(line: 89, column: 5, scope: !151)
!189 = !DILocation(line: 91, column: 5, scope: !151)
!190 = !DILocation(line: 92, column: 5, scope: !151)
