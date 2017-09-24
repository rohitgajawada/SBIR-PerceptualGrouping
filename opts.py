import argparse

def myparser():

    parser = argparse.ArgumentParser(description='PyTorch TFeat Example')

    parser.add_argument('--data', type=str, default='./datasets/sketchy/train/',
                        help='path to dataset')

    opts = parser.parse_args()

    return opts
