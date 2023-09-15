import Tests.Test_Dibujo
import Tests.Test_Pred

main :: IO ()
main = do
  -- Tests that should pass
  putStrLn ("Testing Preds...\n")
  putStrLn ("Testing True cases:")
  test_cambiar_ok
  test_anyDib_ok
  test_allDib_ok
  test_orP_ok
  test_andP_ok

  putStrLn ("\nTesting False cases")
  -- Tests that should fail
  test_anyDib_wrong
  test_allDib_wrong
  test_orP_wrong
  test_andP_wrong

  -- Dibujo tests
  putStrLn ("\nTesting Dibujo...\n")
  test_comp_ok
  test_shared_apilar_ok
  test_cuarteto_ok
  test_superponer_ok
  test_mapDib_ok
  -- Tests that should fail
  test_foldDib_wrong