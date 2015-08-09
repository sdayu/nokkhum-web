import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.rst')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'pyramid',
    'pyramid_tm',
    'pyramid_jinja2',
    'pyramid_debugtoolbar',
    'pyramid_beaker',
    'waitress',
    'mongoengine',
    'wtforms',
    'pycrypto',
    ]

setup(name='nokkhum-web',
      version='0.0',
      description='nokkhum web interface',
      long_description=README + '\n\n' +  CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pylons",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
        ],
      author='Thanathip Limna',
      author_email='thanathip.limna@gmail.com',
      url='',
      keywords='web pyramid nokkhum',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='nokkhumweb',
      install_requires=requires,
      entry_points="""\
      [paste.app_factory]
      main = nokkhumweb:main
      """,
      )

