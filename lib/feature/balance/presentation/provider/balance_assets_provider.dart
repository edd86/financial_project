import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_asset_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';
import 'package:flutter/foundation.dart';

class BalanceAssetsProvider extends ChangeNotifier {
  Response<List<BalanceAsset>> _balanceAssets = Response.success([]);
  int? _currentBalanceId;

  Response<List<BalanceAsset>> get balanceAssets => _balanceAssets;
  int? get currentBalanceId => _currentBalanceId;

  void setBalanceAssets(int balanceId) async {
    _currentBalanceId = balanceId;
    final balanceAssets = await BalanceAssetRepoImpl().getBalanceAssets(
      balanceId,
    );
    _balanceAssets = balanceAssets;
    notifyListeners();
  }

  // Método para refrescar los activos después de una eliminación
  void refreshAssets() {
    if (_currentBalanceId != null) {
      setBalanceAssets(_currentBalanceId!);
    }
  }

  // Método para eliminar un activo y actualizar la lista
  Future<Response<BalanceAsset>> deleteAsset(BalanceAsset asset) async {
    final result = await BalanceAssetRepoImpl().deleteBalanceAsset(asset);
    if (result.success) {
      refreshAssets();
    }
    return result;
  }
}
