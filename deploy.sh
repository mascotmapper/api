# as root, configure gunicorn, nginx
bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    file upload ./appserver.conf /etc/supervisor/conf.d/appserver.conf

bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    file upload ./webserver.conf /etc/nginx/sites-available/default

# as ubuntu, install app and libs
scp -i ~/.ssh/cicd-service-account.pem \
    wsgi.py app.py data.json requirements.txt ubuntu@appserver:~

bolt \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    command run "python3.6 -m venv api/env && source api/env/bin/activate && pip install --upgrade --quiet --requirement requirements.txt"

# as root, restart supervisor, nginx
bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    command run "systemctl restart supervisor nginx"
