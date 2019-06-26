import rdflib
import argparse

parser = argparse.ArgumentParser(description='Rebuild dev environments.')
parser.add_argument('version', type=str,
                    help=('Schema version. '
                          '(See: https://github.com/schemaorg/schemaorg/tree/master/data/releases)'))

parser.add_argument('output', type=str, nargs='?',
                    default='schema.json',
                     help='Output file name',
                    )

if __name__ == '__main__':
    args = parser.parse_args()
    ver = args.version
    g=rdflib.Graph()
    url = f'https://raw.githubusercontent.com/schemaorg/schemaorg/master/data/releases/{ver}/schema.nt'
    g.load(url , format='nt')
    # json_txt = g.serialize(format='json-ld')
    json_ext=g.serialize(format='nt')
    print(json_txt)
    with open(args.output, 'w') as f:
        f.write(json_txt.decode('utf-8'))
