defmodule Evaluator do
  def eval exps do
    { result, _fin } = Enum.reduce exps, { _result = [], _binding = binding()}, &evaluate_with_bindings/2
    Enum.reverse result
  end

  defp evaluate_with_bindings exp, { result, binding } do
    { next, new_binding } = Code.eval_string(exp, binding)
    { [ "value> #{ next }", "code> #{ exp }" | result ], new_binding }
  end
end
