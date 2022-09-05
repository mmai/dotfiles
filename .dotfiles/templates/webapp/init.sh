echo "--> Initialisation de l'environnement"
cargo init 

echo "--> Installation du serveur web"
cargo add warp
cargo add tokio --features full
cp step_templates/01-webserver/main.rs src/main.rs

echo "--> Fichier de configuration"

echo "Initialisation de l'ORM"

# - entities / orm
# - i18n
# - utilisateurs / rôles
# - auth
# - cache
# - formulaires
# - admin / crud
# - api
# - front
#   - templating
#   - js framwork
#   - webassembly
#   - websocket
