from setuptools import find_packages, setup

setup(
    name='sops-pre-commit',
    description='Check for unencrypted Kubernetes secrets in manifest files',
    url='https://github.com/k8s-at-home/sops-pre-commit',
    version='2.0.0',

    author='Devin Buhl',
    author_email='devin.kray@gmail.com',

    platforms='linux',
    classifiers=[
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: Implementation :: CPython',
        'Programming Language :: Python :: Implementation :: PyPy',
    ],

    packages=find_packages('.'),
    entry_points={
        'console_scripts': [
            'forbid_secrets = hooks.forbid_secrets:main',
        ],
    },
)
