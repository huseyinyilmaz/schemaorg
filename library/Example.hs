{-# LANGUAGE OverloadedStrings #-}

-- | An example module.

module Example (main) where

import Data.RDF
import Data.RDF.Graph.AdjHashMap

-- | An example function.
main :: IO ()
main = do
    -- Right (rdf) <- (parseURL (NTriplesParser) "https://raw.githubusercontent.com/schemaorg/schemaorg/master/data/releases/3.7/schema.nt") :: (IO (Either ParseFailure (RDF TList)))

    Right (rdf) <- (parseURL (NTriplesParser) "https://raw.githubusercontent.com/schemaorg/schemaorg/master/data/releases/3.7/schema.nt") :: (IO (Either ParseFailure (RDF AdjHashMap)))

    -- let ts = query rdf (Just (UNode "http://www.w3.org/2011/Talks/0331-hyderabad-tbl/data#talk")) (Just (UNode "dct:title")) Nothing
    -- let talks = fmap (\(Triple _ _ (LNode (PlainL s))) -> s) ts
    print rdf
