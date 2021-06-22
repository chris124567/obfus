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
@testArrayXor = internal unnamed_addr constant [7 x i32] [i32 1, i32 0, i32 -5, i32 0, i32 3, i32 7, i32 2147483647], align 16, !dbg !15
@.str.3 = private unnamed_addr constant [4 x i8] c"xor\00", align 1
@testArrayOr = internal unnamed_addr constant [7 x i32] [i32 -5, i32 0, i32 -5, i32 1, i32 3, i32 7, i32 2147483647], align 16, !dbg !17
@.str.4 = private unnamed_addr constant [3 x i8] c"or\00", align 1
@testArrayAnd = internal unnamed_addr constant [7 x i32] [i32 -6, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0], align 16, !dbg !19
@.str.5 = private unnamed_addr constant [4 x i8] c"and\00", align 1
@.str.6 = private unnamed_addr constant [13 x i8] c"password(-2)\00", align 1
@.str.7 = private unnamed_addr constant [13 x i8] c"password(-1)\00", align 1
@.str.8 = private unnamed_addr constant [12 x i8] c"password(0)\00", align 1
@.str.9 = private unnamed_addr constant [12 x i8] c"password(1)\00", align 1
@.str.10 = private unnamed_addr constant [12 x i8] c"password(2)\00", align 1
@.str.11 = private unnamed_addr constant [12 x i8] c"password(3)\00", align 1
@.str.12 = private unnamed_addr constant [12 x i8] c"password(4)\00", align 1
@.str.13 = private unnamed_addr constant [15 x i8] c"password(5000)\00", align 1
@.str.14 = private unnamed_addr constant [13 x i8] c"password8(0)\00", align 1
@.str.15 = private unnamed_addr constant [13 x i8] c"password8(1)\00", align 1
@.str.16 = private unnamed_addr constant [13 x i8] c"password8(2)\00", align 1
@.str.17 = private unnamed_addr constant [13 x i8] c"password8(3)\00", align 1
@.str.18 = private unnamed_addr constant [13 x i8] c"password8(4)\00", align 1
@str = private unnamed_addr constant [16 x i8] c"Finished tests!\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !28 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !32, metadata !DIExpression()), !dbg !38
  store i32 %1, i32* %4, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %4, metadata !33, metadata !DIExpression()), !dbg !39
  %5 = load i32, i32* %3, align 4, !dbg !40, !tbaa !34
  %6 = load i32, i32* %4, align 4, !dbg !41, !tbaa !34
  %7 = add nsw i32 %5, %6, !dbg !42
  ret i32 %7, !dbg !43
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sub(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !44 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !46, metadata !DIExpression()), !dbg !48
  store i32 %1, i32* %4, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %4, metadata !47, metadata !DIExpression()), !dbg !49
  %5 = load i32, i32* %3, align 4, !dbg !50, !tbaa !34
  %6 = load i32, i32* %4, align 4, !dbg !51, !tbaa !34
  %7 = sub nsw i32 %5, %6, !dbg !52
  ret i32 %7, !dbg !53
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xor1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !54 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !56, metadata !DIExpression()), !dbg !58
  store i32 %1, i32* %4, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %4, metadata !57, metadata !DIExpression()), !dbg !59
  %5 = load i32, i32* %3, align 4, !dbg !60, !tbaa !34
  %6 = load i32, i32* %4, align 4, !dbg !61, !tbaa !34
  %7 = xor i32 %5, %6, !dbg !62
  ret i32 %7, !dbg !63
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @or1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !64 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !66, metadata !DIExpression()), !dbg !68
  store i32 %1, i32* %4, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %4, metadata !67, metadata !DIExpression()), !dbg !69
  %5 = load i32, i32* %3, align 4, !dbg !70, !tbaa !34
  %6 = load i32, i32* %4, align 4, !dbg !71, !tbaa !34
  %7 = or i32 %5, %6, !dbg !72
  ret i32 %7, !dbg !73
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @and1(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !74 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !76, metadata !DIExpression()), !dbg !78
  store i32 %1, i32* %4, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %4, metadata !77, metadata !DIExpression()), !dbg !79
  %5 = load i32, i32* %3, align 4, !dbg !80, !tbaa !34
  %6 = load i32, i32* %4, align 4, !dbg !81, !tbaa !34
  %7 = and i32 %5, %6, !dbg !82
  ret i32 %7, !dbg !83
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @password(i32 %0) local_unnamed_addr #0 !dbg !84 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4, !tbaa !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !88, metadata !DIExpression()), !dbg !89
  %4 = load i32, i32* %3, align 4, !dbg !90, !tbaa !34
  %5 = icmp sge i32 %4, 0, !dbg !92
  br i1 %5, label %6, label %14, !dbg !93

6:                                                ; preds = %1
  %7 = load i32, i32* %3, align 4, !dbg !94, !tbaa !34
  %8 = icmp slt i32 %7, 5, !dbg !95
  br i1 %8, label %9, label %14, !dbg !96

9:                                                ; preds = %6
  %10 = load i32, i32* %3, align 4, !dbg !97, !tbaa !34
  %11 = and i32 %10, 1, !dbg !98
  %12 = icmp eq i32 %11, 0, !dbg !99
  br i1 %12, label %13, label %14, !dbg !100

13:                                               ; preds = %9
  store i32 1337, i32* %2, align 4, !dbg !101
  br label %15, !dbg !101

14:                                               ; preds = %9, %6, %1
  store i32 -1, i32* %2, align 4, !dbg !103
  br label %15, !dbg !103

15:                                               ; preds = %14, %13
  %16 = load i32, i32* %2, align 4, !dbg !105
  ret i32 %16, !dbg !105
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @password8(i8 zeroext %0) local_unnamed_addr #0 !dbg !106 {
  %2 = alloca i8, align 1
  %3 = alloca i8, align 1
  store i8 %0, i8* %3, align 1, !tbaa !117
  call void @llvm.dbg.declare(metadata i8* %3, metadata !116, metadata !DIExpression()), !dbg !118
  %4 = load i8, i8* %3, align 1, !dbg !119, !tbaa !117
  %5 = zext i8 %4 to i32, !dbg !119
  %6 = icmp sge i32 %5, 0, !dbg !121
  br i1 %6, label %7, label %17, !dbg !122

7:                                                ; preds = %1
  %8 = load i8, i8* %3, align 1, !dbg !123, !tbaa !117
  %9 = zext i8 %8 to i32, !dbg !123
  %10 = icmp slt i32 %9, 5, !dbg !124
  br i1 %10, label %11, label %17, !dbg !125

11:                                               ; preds = %7
  %12 = load i8, i8* %3, align 1, !dbg !126, !tbaa !117
  %13 = zext i8 %12 to i32, !dbg !126
  %14 = and i32 %13, 1, !dbg !127
  %15 = icmp eq i32 %14, 0, !dbg !128
  br i1 %15, label %16, label %17, !dbg !129

16:                                               ; preds = %11
  store i8 111, i8* %2, align 1, !dbg !130
  br label %18, !dbg !130

17:                                               ; preds = %11, %7, %1
  store i8 0, i8* %2, align 1, !dbg !132
  br label %18, !dbg !132

18:                                               ; preds = %17, %16
  %19 = load i8, i8* %2, align 1, !dbg !134
  ret i8 %19, !dbg !134
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @return5000() local_unnamed_addr #0 !dbg !135 {
  ret i32 5000, !dbg !138
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 !dbg !139 {
  call void @llvm.dbg.value(metadata i32 0, metadata !141, metadata !DIExpression()), !dbg !148
  br label %1, !dbg !149

1:                                                ; preds = %46, %0
  %2 = phi i64 [ 0, %0 ], [ %47, %46 ]
  call void @llvm.dbg.value(metadata i64 %2, metadata !141, metadata !DIExpression()), !dbg !148
  %3 = getelementptr inbounds [7 x [2 x i32]], [7 x [2 x i32]]* @testArray, i64 0, i64 %2, i64 0, !dbg !150
  %4 = load i32, i32* %3, align 8, !dbg !150, !tbaa !34
  call void @llvm.dbg.value(metadata i32 %4, metadata !143, metadata !DIExpression()), !dbg !151
  %5 = getelementptr inbounds [7 x [2 x i32]], [7 x [2 x i32]]* @testArray, i64 0, i64 %2, i64 1, !dbg !152
  %6 = load i32, i32* %5, align 4, !dbg !152, !tbaa !34
  call void @llvm.dbg.value(metadata i32 %6, metadata !147, metadata !DIExpression()), !dbg !151
  %7 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayAdd, i64 0, i64 %2, !dbg !153
  %8 = load i32, i32* %7, align 4, !dbg !153, !tbaa !34
  %9 = tail call i32 @add(i32 %4, i32 %6), !dbg !153
  %10 = icmp eq i32 %8, %9, !dbg !153
  br i1 %10, label %14, label %11, !dbg !153

11:                                               ; preds = %1
  %12 = tail call i32 @add(i32 %4, i32 %6), !dbg !153
  %13 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 %8, i32 %12), !dbg !153
  br label %14, !dbg !153

14:                                               ; preds = %1, %11
  %15 = getelementptr inbounds [7 x i32], [7 x i32]* @testArraySub, i64 0, i64 %2, !dbg !154
  %16 = load i32, i32* %15, align 4, !dbg !154, !tbaa !34
  %17 = tail call i32 @sub(i32 %4, i32 %6), !dbg !154
  %18 = icmp eq i32 %16, %17, !dbg !154
  br i1 %18, label %22, label %19, !dbg !154

19:                                               ; preds = %14
  %20 = tail call i32 @sub(i32 %4, i32 %6), !dbg !154
  %21 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0), i32 %16, i32 %20), !dbg !154
  br label %22, !dbg !154

22:                                               ; preds = %14, %19
  %23 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayXor, i64 0, i64 %2, !dbg !155
  %24 = load i32, i32* %23, align 4, !dbg !155, !tbaa !34
  %25 = tail call i32 @xor1(i32 %4, i32 %6), !dbg !155
  %26 = icmp eq i32 %24, %25, !dbg !155
  br i1 %26, label %30, label %27, !dbg !155

27:                                               ; preds = %22
  %28 = tail call i32 @xor1(i32 %4, i32 %6), !dbg !155
  %29 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 %24, i32 %28), !dbg !155
  br label %30, !dbg !155

30:                                               ; preds = %22, %27
  %31 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayOr, i64 0, i64 %2, !dbg !156
  %32 = load i32, i32* %31, align 4, !dbg !156, !tbaa !34
  %33 = tail call i32 @or1(i32 %4, i32 %6), !dbg !156
  %34 = icmp eq i32 %32, %33, !dbg !156
  br i1 %34, label %38, label %35, !dbg !156

35:                                               ; preds = %30
  %36 = tail call i32 @or1(i32 %4, i32 %6), !dbg !156
  %37 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32 %32, i32 %36), !dbg !156
  br label %38, !dbg !156

38:                                               ; preds = %30, %35
  %39 = getelementptr inbounds [7 x i32], [7 x i32]* @testArrayAnd, i64 0, i64 %2, !dbg !157
  %40 = load i32, i32* %39, align 4, !dbg !157, !tbaa !34
  %41 = tail call i32 @and1(i32 %4, i32 %6), !dbg !157
  %42 = icmp eq i32 %40, %41, !dbg !157
  br i1 %42, label %46, label %43, !dbg !157

43:                                               ; preds = %38
  %44 = tail call i32 @and1(i32 %4, i32 %6), !dbg !157
  %45 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i64 0, i64 0), i32 %40, i32 %44), !dbg !157
  br label %46, !dbg !157

46:                                               ; preds = %38, %43
  %47 = add nuw nsw i64 %2, 1, !dbg !158
  call void @llvm.dbg.value(metadata i64 %47, metadata !141, metadata !DIExpression()), !dbg !148
  %48 = icmp eq i64 %47, 7, !dbg !159
  br i1 %48, label %49, label %1, !dbg !149, !llvm.loop !160

49:                                               ; preds = %46
  %50 = tail call i32 @password(i32 -2), !dbg !162
  %51 = icmp eq i32 %50, -1, !dbg !162
  br i1 %51, label %55, label %52, !dbg !162

52:                                               ; preds = %49
  %53 = tail call i32 @password(i32 -2), !dbg !162
  %54 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.6, i64 0, i64 0), i32 %53, i32 -1), !dbg !162
  br label %55, !dbg !162

55:                                               ; preds = %49, %52
  %56 = tail call i32 @password(i32 -1), !dbg !163
  %57 = icmp eq i32 %56, -1, !dbg !163
  br i1 %57, label %61, label %58, !dbg !163

58:                                               ; preds = %55
  %59 = tail call i32 @password(i32 -1), !dbg !163
  %60 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.7, i64 0, i64 0), i32 %59, i32 -1), !dbg !163
  br label %61, !dbg !163

61:                                               ; preds = %55, %58
  %62 = tail call i32 @password(i32 0), !dbg !164
  %63 = icmp eq i32 %62, 1337, !dbg !164
  br i1 %63, label %67, label %64, !dbg !164

64:                                               ; preds = %61
  %65 = tail call i32 @password(i32 0), !dbg !164
  %66 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.8, i64 0, i64 0), i32 %65, i32 1337), !dbg !164
  br label %67, !dbg !164

67:                                               ; preds = %61, %64
  %68 = tail call i32 @password(i32 1), !dbg !165
  %69 = icmp eq i32 %68, -1, !dbg !165
  br i1 %69, label %73, label %70, !dbg !165

70:                                               ; preds = %67
  %71 = tail call i32 @password(i32 1), !dbg !165
  %72 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.9, i64 0, i64 0), i32 %71, i32 -1), !dbg !165
  br label %73, !dbg !165

73:                                               ; preds = %67, %70
  %74 = tail call i32 @password(i32 2), !dbg !166
  %75 = icmp eq i32 %74, 1337, !dbg !166
  br i1 %75, label %79, label %76, !dbg !166

76:                                               ; preds = %73
  %77 = tail call i32 @password(i32 2), !dbg !166
  %78 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.10, i64 0, i64 0), i32 %77, i32 1337), !dbg !166
  br label %79, !dbg !166

79:                                               ; preds = %73, %76
  %80 = tail call i32 @password(i32 3), !dbg !167
  %81 = icmp eq i32 %80, -1, !dbg !167
  br i1 %81, label %85, label %82, !dbg !167

82:                                               ; preds = %79
  %83 = tail call i32 @password(i32 3), !dbg !167
  %84 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.11, i64 0, i64 0), i32 %83, i32 -1), !dbg !167
  br label %85, !dbg !167

85:                                               ; preds = %79, %82
  %86 = tail call i32 @password(i32 4), !dbg !168
  %87 = icmp eq i32 %86, 1337, !dbg !168
  br i1 %87, label %91, label %88, !dbg !168

88:                                               ; preds = %85
  %89 = tail call i32 @password(i32 4), !dbg !168
  %90 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.12, i64 0, i64 0), i32 %89, i32 1337), !dbg !168
  br label %91, !dbg !168

91:                                               ; preds = %85, %88
  %92 = tail call i32 @password(i32 5000), !dbg !169
  %93 = icmp eq i32 %92, -1, !dbg !169
  br i1 %93, label %97, label %94, !dbg !169

94:                                               ; preds = %91
  %95 = tail call i32 @password(i32 5000), !dbg !169
  %96 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.13, i64 0, i64 0), i32 %95, i32 -1), !dbg !169
  br label %97, !dbg !169

97:                                               ; preds = %91, %94
  %98 = tail call zeroext i8 @password8(i8 zeroext 0), !dbg !170
  %99 = icmp eq i8 %98, 111, !dbg !170
  br i1 %99, label %104, label %100, !dbg !170

100:                                              ; preds = %97
  %101 = tail call zeroext i8 @password8(i8 zeroext 0), !dbg !170
  %102 = zext i8 %101 to i32, !dbg !170
  %103 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.14, i64 0, i64 0), i32 %102, i32 111), !dbg !170
  br label %104, !dbg !170

104:                                              ; preds = %97, %100
  %105 = tail call zeroext i8 @password8(i8 zeroext 1), !dbg !171
  %106 = icmp eq i8 %105, 0, !dbg !171
  br i1 %106, label %111, label %107, !dbg !171

107:                                              ; preds = %104
  %108 = tail call zeroext i8 @password8(i8 zeroext 1), !dbg !171
  %109 = zext i8 %108 to i32, !dbg !171
  %110 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.15, i64 0, i64 0), i32 %109, i32 0), !dbg !171
  br label %111, !dbg !171

111:                                              ; preds = %104, %107
  %112 = tail call zeroext i8 @password8(i8 zeroext 2), !dbg !172
  %113 = icmp eq i8 %112, 111, !dbg !172
  br i1 %113, label %118, label %114, !dbg !172

114:                                              ; preds = %111
  %115 = tail call zeroext i8 @password8(i8 zeroext 2), !dbg !172
  %116 = zext i8 %115 to i32, !dbg !172
  %117 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.16, i64 0, i64 0), i32 %116, i32 111), !dbg !172
  br label %118, !dbg !172

118:                                              ; preds = %111, %114
  %119 = tail call zeroext i8 @password8(i8 zeroext 3), !dbg !173
  %120 = icmp eq i8 %119, 0, !dbg !173
  br i1 %120, label %125, label %121, !dbg !173

121:                                              ; preds = %118
  %122 = tail call zeroext i8 @password8(i8 zeroext 3), !dbg !173
  %123 = zext i8 %122 to i32, !dbg !173
  %124 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.17, i64 0, i64 0), i32 %123, i32 0), !dbg !173
  br label %125, !dbg !173

125:                                              ; preds = %118, %121
  %126 = tail call zeroext i8 @password8(i8 zeroext 4), !dbg !174
  %127 = icmp eq i8 %126, 111, !dbg !174
  br i1 %127, label %132, label %128, !dbg !174

128:                                              ; preds = %125
  %129 = tail call zeroext i8 @password8(i8 zeroext 4), !dbg !174
  %130 = zext i8 %129 to i32, !dbg !174
  %131 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.18, i64 0, i64 0), i32 %130, i32 111), !dbg !174
  br label %132, !dbg !174

132:                                              ; preds = %125, %128
  %133 = tail call i32 @return5000(), !dbg !175
  %134 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @str, i64 0, i64 0)), !dbg !176
  ret i32 0, !dbg !177
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
!llvm.module.flags = !{!24, !25, !26}
!llvm.ident = !{!27}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "testArray", scope: !2, file: !3, line: 49, type: !21, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C89, file: !3, producer: "Debian clang version 11.1.0-++20210428103820+1fdec59bffc1-1~exp1~20210428204437.162", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test/test.c", directory: "/home/christopher/prog/cpp/obfus")
!4 = !{}
!5 = !{!0, !6, !13, !15, !17, !19}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "testArrayAdd", scope: !2, file: !3, line: 50, type: !8, isLocal: true, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 224, elements: !11)
!9 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!12}
!12 = !DISubrange(count: 7)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "testArraySub", scope: !2, file: !3, line: 51, type: !8, isLocal: true, isDefinition: true)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "testArrayXor", scope: !2, file: !3, line: 52, type: !8, isLocal: true, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "testArrayOr", scope: !2, file: !3, line: 53, type: !8, isLocal: true, isDefinition: true)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(name: "testArrayAnd", scope: !2, file: !3, line: 54, type: !8, isLocal: true, isDefinition: true)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 448, elements: !22)
!22 = !{!12, !23}
!23 = !DISubrange(count: 2)
!24 = !{i32 7, !"Dwarf Version", i32 4}
!25 = !{i32 2, !"Debug Info Version", i32 3}
!26 = !{i32 1, !"wchar_size", i32 4}
!27 = !{!"Debian clang version 11.1.0-++20210428103820+1fdec59bffc1-1~exp1~20210428204437.162"}
!28 = distinct !DISubprogram(name: "add", scope: !3, file: !3, line: 5, type: !29, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !31)
!29 = !DISubroutineType(types: !30)
!30 = !{!10, !9, !9}
!31 = !{!32, !33}
!32 = !DILocalVariable(name: "x", arg: 1, scope: !28, file: !3, line: 5, type: !9)
!33 = !DILocalVariable(name: "y", arg: 2, scope: !28, file: !3, line: 5, type: !9)
!34 = !{!35, !35, i64 0}
!35 = !{!"int", !36, i64 0}
!36 = !{!"omnipotent char", !37, i64 0}
!37 = !{!"Simple C/C++ TBAA"}
!38 = !DILocation(line: 5, column: 44, scope: !28)
!39 = !DILocation(line: 5, column: 57, scope: !28)
!40 = !DILocation(line: 6, column: 12, scope: !28)
!41 = !DILocation(line: 6, column: 16, scope: !28)
!42 = !DILocation(line: 6, column: 14, scope: !28)
!43 = !DILocation(line: 6, column: 5, scope: !28)
!44 = distinct !DISubprogram(name: "sub", scope: !3, file: !3, line: 9, type: !29, scopeLine: 9, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !45)
!45 = !{!46, !47}
!46 = !DILocalVariable(name: "x", arg: 1, scope: !44, file: !3, line: 9, type: !9)
!47 = !DILocalVariable(name: "y", arg: 2, scope: !44, file: !3, line: 9, type: !9)
!48 = !DILocation(line: 9, column: 44, scope: !44)
!49 = !DILocation(line: 9, column: 57, scope: !44)
!50 = !DILocation(line: 10, column: 12, scope: !44)
!51 = !DILocation(line: 10, column: 16, scope: !44)
!52 = !DILocation(line: 10, column: 14, scope: !44)
!53 = !DILocation(line: 10, column: 5, scope: !44)
!54 = distinct !DISubprogram(name: "xor1", scope: !3, file: !3, line: 16, type: !29, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !55)
!55 = !{!56, !57}
!56 = !DILocalVariable(name: "x", arg: 1, scope: !54, file: !3, line: 16, type: !9)
!57 = !DILocalVariable(name: "y", arg: 2, scope: !54, file: !3, line: 16, type: !9)
!58 = !DILocation(line: 16, column: 45, scope: !54)
!59 = !DILocation(line: 16, column: 58, scope: !54)
!60 = !DILocation(line: 17, column: 12, scope: !54)
!61 = !DILocation(line: 17, column: 16, scope: !54)
!62 = !DILocation(line: 17, column: 14, scope: !54)
!63 = !DILocation(line: 17, column: 5, scope: !54)
!64 = distinct !DISubprogram(name: "or1", scope: !3, file: !3, line: 20, type: !29, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !65)
!65 = !{!66, !67}
!66 = !DILocalVariable(name: "x", arg: 1, scope: !64, file: !3, line: 20, type: !9)
!67 = !DILocalVariable(name: "y", arg: 2, scope: !64, file: !3, line: 20, type: !9)
!68 = !DILocation(line: 20, column: 44, scope: !64)
!69 = !DILocation(line: 20, column: 57, scope: !64)
!70 = !DILocation(line: 21, column: 12, scope: !64)
!71 = !DILocation(line: 21, column: 16, scope: !64)
!72 = !DILocation(line: 21, column: 14, scope: !64)
!73 = !DILocation(line: 21, column: 5, scope: !64)
!74 = distinct !DISubprogram(name: "and1", scope: !3, file: !3, line: 24, type: !29, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !75)
!75 = !{!76, !77}
!76 = !DILocalVariable(name: "x", arg: 1, scope: !74, file: !3, line: 24, type: !9)
!77 = !DILocalVariable(name: "y", arg: 2, scope: !74, file: !3, line: 24, type: !9)
!78 = !DILocation(line: 24, column: 45, scope: !74)
!79 = !DILocation(line: 24, column: 58, scope: !74)
!80 = !DILocation(line: 25, column: 12, scope: !74)
!81 = !DILocation(line: 25, column: 16, scope: !74)
!82 = !DILocation(line: 25, column: 14, scope: !74)
!83 = !DILocation(line: 25, column: 5, scope: !74)
!84 = distinct !DISubprogram(name: "password", scope: !3, file: !3, line: 28, type: !85, scopeLine: 28, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !87)
!85 = !DISubroutineType(types: !86)
!86 = !{!10, !9}
!87 = !{!88}
!88 = !DILocalVariable(name: "input", arg: 1, scope: !84, file: !3, line: 28, type: !9)
!89 = !DILocation(line: 28, column: 49, scope: !84)
!90 = !DILocation(line: 29, column: 9, scope: !91)
!91 = distinct !DILexicalBlock(scope: !84, file: !3, line: 29, column: 9)
!92 = !DILocation(line: 29, column: 15, scope: !91)
!93 = !DILocation(line: 29, column: 20, scope: !91)
!94 = !DILocation(line: 29, column: 23, scope: !91)
!95 = !DILocation(line: 29, column: 29, scope: !91)
!96 = !DILocation(line: 29, column: 33, scope: !91)
!97 = !DILocation(line: 29, column: 37, scope: !91)
!98 = !DILocation(line: 29, column: 43, scope: !91)
!99 = !DILocation(line: 29, column: 48, scope: !91)
!100 = !DILocation(line: 29, column: 9, scope: !84)
!101 = !DILocation(line: 30, column: 9, scope: !102)
!102 = distinct !DILexicalBlock(scope: !91, file: !3, line: 29, column: 54)
!103 = !DILocation(line: 32, column: 9, scope: !104)
!104 = distinct !DILexicalBlock(scope: !91, file: !3, line: 31, column: 12)
!105 = !DILocation(line: 34, column: 1, scope: !84)
!106 = distinct !DISubprogram(name: "password8", scope: !3, file: !3, line: 36, type: !107, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !115)
!107 = !DISubroutineType(types: !108)
!108 = !{!109, !114}
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !110, line: 24, baseType: !111)
!110 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!111 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !112, line: 37, baseType: !113)
!112 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!113 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!114 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !109)
!115 = !{!116}
!116 = !DILocalVariable(name: "input", arg: 1, scope: !106, file: !3, line: 36, type: !114)
!117 = !{!36, !36, i64 0}
!118 = !DILocation(line: 36, column: 58, scope: !106)
!119 = !DILocation(line: 37, column: 9, scope: !120)
!120 = distinct !DILexicalBlock(scope: !106, file: !3, line: 37, column: 9)
!121 = !DILocation(line: 37, column: 15, scope: !120)
!122 = !DILocation(line: 37, column: 20, scope: !120)
!123 = !DILocation(line: 37, column: 23, scope: !120)
!124 = !DILocation(line: 37, column: 29, scope: !120)
!125 = !DILocation(line: 37, column: 33, scope: !120)
!126 = !DILocation(line: 37, column: 37, scope: !120)
!127 = !DILocation(line: 37, column: 43, scope: !120)
!128 = !DILocation(line: 37, column: 48, scope: !120)
!129 = !DILocation(line: 37, column: 9, scope: !106)
!130 = !DILocation(line: 38, column: 9, scope: !131)
!131 = distinct !DILexicalBlock(scope: !120, file: !3, line: 37, column: 54)
!132 = !DILocation(line: 40, column: 9, scope: !133)
!133 = distinct !DILexicalBlock(scope: !120, file: !3, line: 39, column: 12)
!134 = !DILocation(line: 42, column: 1, scope: !106)
!135 = distinct !DISubprogram(name: "return5000", scope: !3, file: !3, line: 44, type: !136, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!136 = !DISubroutineType(types: !137)
!137 = !{!10}
!138 = !DILocation(line: 45, column: 5, scope: !135)
!139 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 58, type: !136, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !140)
!140 = !{!141, !143, !147}
!141 = !DILocalVariable(name: "i", scope: !139, file: !3, line: 59, type: !142)
!142 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!143 = !DILocalVariable(name: "x", scope: !144, file: !3, line: 61, type: !9)
!144 = distinct !DILexicalBlock(scope: !145, file: !3, line: 60, column: 68)
!145 = distinct !DILexicalBlock(scope: !146, file: !3, line: 60, column: 5)
!146 = distinct !DILexicalBlock(scope: !139, file: !3, line: 60, column: 5)
!147 = !DILocalVariable(name: "y", scope: !144, file: !3, line: 62, type: !9)
!148 = !DILocation(line: 0, scope: !139)
!149 = !DILocation(line: 60, column: 5, scope: !146)
!150 = !DILocation(line: 61, column: 23, scope: !144)
!151 = !DILocation(line: 0, scope: !144)
!152 = !DILocation(line: 62, column: 23, scope: !144)
!153 = !DILocation(line: 63, column: 9, scope: !144)
!154 = !DILocation(line: 64, column: 9, scope: !144)
!155 = !DILocation(line: 65, column: 9, scope: !144)
!156 = !DILocation(line: 66, column: 9, scope: !144)
!157 = !DILocation(line: 67, column: 9, scope: !144)
!158 = !DILocation(line: 60, column: 64, scope: !145)
!159 = !DILocation(line: 60, column: 19, scope: !145)
!160 = distinct !{!160, !149, !161}
!161 = !DILocation(line: 68, column: 5, scope: !146)
!162 = !DILocation(line: 69, column: 5, scope: !139)
!163 = !DILocation(line: 70, column: 5, scope: !139)
!164 = !DILocation(line: 71, column: 5, scope: !139)
!165 = !DILocation(line: 72, column: 5, scope: !139)
!166 = !DILocation(line: 73, column: 5, scope: !139)
!167 = !DILocation(line: 74, column: 5, scope: !139)
!168 = !DILocation(line: 75, column: 5, scope: !139)
!169 = !DILocation(line: 76, column: 5, scope: !139)
!170 = !DILocation(line: 77, column: 5, scope: !139)
!171 = !DILocation(line: 78, column: 5, scope: !139)
!172 = !DILocation(line: 79, column: 5, scope: !139)
!173 = !DILocation(line: 80, column: 5, scope: !139)
!174 = !DILocation(line: 81, column: 5, scope: !139)
!175 = !DILocation(line: 82, column: 5, scope: !139)
!176 = !DILocation(line: 84, column: 5, scope: !139)
!177 = !DILocation(line: 85, column: 5, scope: !139)
