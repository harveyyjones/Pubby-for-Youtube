# pubby_for_youtube
`19.10.2022 Çarşamba`
İlk stepper kısmında girilen profil fotoğrafı, biyografi ve isim direkt database'e yazılıyor. Uygulamamnın kalan kısmında yine data'dan çekiliyor. Değiştirildiğinde yine önce data güncelleniyor. Realtime database olduğu için ekstra state management çözümüne gerek kalmamasını umuyorum.


# Yapılması gerekenler `20.10.2022`
Belli unique ID ile birlikte veri tabanına isim, e mail, profil fotosu verilerini yazdırıyorum. Stepper ksımında hepsini halledebilirim. Sonrasında ayarlar kısmında update etme işlemlerini yaparım.

Createuser() veya loginwithemailandpassword() gibi metodların döndüğü veriyi toMap() diyerek veritabanına gönderebiliyoruz. saveUser() metoduna o veriyi dönmemiz lazım. Ancak eklememiz gereken çeşitli veriler daha var (profil fotosu, biyografi vs.). Onları da ekleyerek tek bir değişkene koyup postlayacağız. 