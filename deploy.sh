# as root, configure gunicorn, nginx
bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    file upload ./conf/appserver.conf /etc/supervisor/conf.d/appserver.conf

bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    file upload ./conf/webserver.conf /etc/nginx/sites-available/default

# as ubuntu, install app and libs
rsync -avz -e "ssh -i ~/.ssh/appserver.pem" \
    --exclude .*~ \
    --exclude .git \
    --exclude .pytest_cache \
    --exclude __pycache__ \
    . ubuntu@ec2-54-244-166-211.us-west-2.compute.amazonaws.com:~

bolt \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    command run "python3.6 -m venv env && source env/bin/activate && pip install --upgrade --quiet --requirement requirements.txt"

# as root, restart supervisor, nginx
bolt --run-as root \
    --inventoryfile ./inventory.yml \
    --nodes servers \
    command run "systemctl restart supervisor nginx"
