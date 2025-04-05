# burada gradle ve jdk17 kullanarak build aşaması başlatıyoruz
FROM gradle:7.6.2-jdk17 AS build  

# çalışma dizinini /app olarak ayarlıyoruz
WORKDIR /app  

# mevcut dizindeki tüm dosyaları konteynıra kopyalıyoruz
COPY . .  

# gradle ile build işlemini yapıyoruz, testleri dışarıda bırakıyoruz
RUN gradle build -x test  

# ikinci aşama için daha hafif olan openjdk 17 slim imajını kullanıyoruz
FROM openjdk:17-jdk-slim  

# tekrar çalışma dizinini /app olarak ayarlıyoruz
WORKDIR /app  


# build aşamasından jar dosyasını kopyalıyoruz
RUN cp /app/build/libs/*.jar /app/app.jar  
# son olarak app.jar dosyasını çalıştırıyoruz
CMD ["java", "-jar", "app.jar"]  