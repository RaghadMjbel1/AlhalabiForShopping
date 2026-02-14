# المرحلة 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# نسخ ملف المشروع واستعادة الحزم
COPY *.csproj ./
RUN dotnet restore

# نسخ كل الملفات وبناء المشروع
COPY . ./
RUN dotnet publish -c Release -o out

# المرحلة 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# نسخ الملفات المنشورة من مرحلة البناء
COPY --from=build /app/out .

# السماح بالمنفذ 8080
EXPOSE 8080

# تشغيل المشروع
ENTRYPOINT ["dotnet", "AlhalabiForShopping.dll"]
