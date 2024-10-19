#Add Repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.natesales.net/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/natesales.gpg
echo "deb [signed-by=/etc/apt/keyrings/natesales.gpg] https://repo.natesales.net/apt * *" | sudo tee /etc/apt/sources.list.d/natesales.list

#Update APT
apt update 2>&1 >/dev/null

#Install "q"
apt install q -y 2>&1 >/dev/null
