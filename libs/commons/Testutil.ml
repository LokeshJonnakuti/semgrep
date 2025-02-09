(*
   Various utilities used for testing and are not considered an extension
   of Alcotest (e.g. because it depends on Semgrep-specific libraries).
*)

let run what f =
  UPrintf.printf "running %s...\n%!" what;
  Common.protect ~finally:(fun () -> UPrintf.printf "done with %s.\n%!" what) f

(* TODO: move this to Testo once it's ok with requiring ocaml >= 4.13
   (needed for Unix.realpath) *)
let mask_temp_paths ?depth ?replace () =
  let mask_original_path = Testo.mask_temp_paths ?depth ?replace () in
  let mask_physical_path =
    Testo.mask_temp_paths ?depth ?replace
      ~tmpdir:(UFilename.get_temp_dir_name () |> UUnix.realpath)
      ()
  in
  (* NOTE: Haven't investigated why yet, but order is important here,
   *       we must mask the physical path before the original path. *)
  fun text -> text |> mask_physical_path |> mask_original_path
