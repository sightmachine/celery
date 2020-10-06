# Testing Setup

It's been some time since the last Celery version update, so the default versions of packages used
have now progressed considerably and in many cases broke the test system.

Therefore we strongly suggest using a Python virtual environment with a specific Python version
like so:

```bash
# If you don't have mkvirtualenv, do `pip install virtualenvwrapper`

mkvirtualenv --python=/usr/local/bin/python3.6 celery
cd celery
workon celery
```

You must run a 3.6.x version of Python, I'm running the official Python 3.6.8
distribution for Mac computers for example.

# Package versions

We must freeze the following packages in time, since they changed considerably since Celery
version 4.0.2 which is what we're running as of this writing.

```bash
pip install eventlet==0.20.0 celery==4.0.2 kombu==4.1.0 pytest==3.10.1 vine==1.3.0
```

Then proceed to install the regular requirements

```bash
python setup.py develop
pip install -U -r requirements/default.txt requirements/test.txt requirements/deps/mock.txt
```

Then, you should be ready to run the tests from root celery directory:

```bash
pytest t/unit
```

