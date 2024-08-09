cat <<EOF> passwordfile
cluster-admin:$2y$05$IoqmkUJNUJIojtCxtxR8X.sVjnUfKOdnUdzIsP8eK1Ytxe551j10C
hack-admin:$2y$05$qJHEOIcfx..HLNS0mINz2eteTSnrF5TZbb4jIR.NiMG7CZh0IYup2
admin:$2y$05$o2KxD2XwJIx0XUbJV4fLL.r17S6uXvqnfS7MoaZNLiX99JQjMQ7DK
red:$2y$05$k8V3hOVMHiz1nArap5vin.jlU9eX4jtXRSglNpi.M1FrQhROb1LJK
blue:$2y$05$0rv5hqPSWQDItx0nprHt0OcKZJLcbmF22LNTjBstNt/aF9n3AeoLW
green:$2y$05$R133U01c0kPmZaEMp8pK/uB7MuFh/BCMWSvrzxzz5FtBaxvoTcnZG
yellow:$2y$05$s8yFKuJ/czuKgXNqQz2Cwu6BjGKxm8vlGx630gvj2l.oc23oC.xEO
purple:$2y$05$0CnV7QKR5Eietv/l1pDxrud11Qpzq4k.kwoxy3fyGu9mTai4LVTKG
orange:$2y$05$iUFFGDxi.wozmMDCZs2fpecAW4TxPe9i0gQrRVkjzGunn13IRK56S
olive:$2y$05$vErc3P9pc4yUdgbWQnWXO.zQztDun7iVwoOfiRFYcIkY/LWsKA1jO
brown:$2y$05$gl3XdeqK8d8OJo5cI.68leD7bdiSFB3mJ6Fnf0yfUSjY8gBlXRCte
black:$2y$05$crW5.VXPajEpsA28d7EvGuH0yqM0RGfPZVipn3yKwxEyKU68OO4W6
grey:$2y$05$MGDw/10pMYEg5Lq2xJmSH.woQuXRH0Nx4LSlaIxYzg1uMSII9ms12
EOF

rosa create idp --cluster=`rosa list clusters --output json | jq -r '.[].name'` --type htpasswd  --from-file ./passwordfile --name Hackathon
# delete the users from the clusters if they are already bound to any other IDP, in this case IDP name is hackathon
# oc delete user cluster-admin admin red blue green yellow orange purple hack-admin
rosa edit machinepool worker -c `rosa list clusters --output json | jq -r '.[].name'` --replicas=10

