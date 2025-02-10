// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.20;

import {IERC20} from "../IERC20.sol";

/**
 * @dev Interface for the optional metadata functions from the ERC-20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
};
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

pragma solidity ^0.8.20;

import {Context} from "../utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
};
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/ERC20Burnable.sol)

pragma solidity ^0.8.20;

import {ERC20} from "../ERC20.sol";
import {Context} from "../../../utils/Context.sol";

/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
abstract contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys a `value` amount of tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 value) public virtual {
        _burn(_msgSender(), value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, deducting from
     * the caller's allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `value`.
     */
    function burnFrom(address account, uint256 value) public virtual {
        _spendAllowance(account, _msgSender(), value);
        _burn(account, value);
    }
}";

contract ZONACoin is ERC20, Ownable, ERC20Burnable {
    uint256 public maxTxAmount; // Максимальная сумма транзакции
        uint256 public taxPercentage = 5; // 5% налог на транзакции
            address public marketingWallet; // Адрес для маркетинговых средств
                address public liquidityWallet; // Адрес для ликвидности
                    mapping(address => bool) private isExcludedFromTax; // Исключённые из налогообложения адреса

                        constructor() ERC20("ZONA Coin", "ZONA") Ownable(msg.sender) {
                                uint256 totalSupply = 1_000_000_000 * 10**decimals(); // 1 миллиард токенов
                                        _mint(msg.sender, totalSupply);
                                                maxTxAmount = totalSupply / 100; // Лимит 1% от общего предложения
                                                        marketingWallet = msg.sender;
                                                                liquidityWallet = msg.sender;
                                                                        isExcludedFromTax[msg.sender] = true;
                                                                            }

                                                                                // Переопределение функции transfer с добавлением логики налогообложения
                                                                                    function transfer(address recipient, uint256 amount) public override returns (bool) {
                                                                                            _customTransfer(_msgSender(), recipient, amount);
                                                                                                    return true;
                                                                                                        }

                                                                                                            // Переопределение transferFrom с добавлением логики налогообложения
                                                                                                                function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
                                                                                                                        uint256 currentAllowance = allowance(sender, _msgSender());
                                                                                                                                require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
                                                                                                                                        _customTransfer(sender, recipient, amount);
                                                                                                                                                _approve(sender, _msgSender(), currentAllowance - amount);
                                                                                                                                                        return true;
                                                                                                                                                            }

                                                                                                                                                                // Логика пользовательского трансфера
                                                                                                                                                                    function _customTransfer(address sender, address recipient, uint256 amount) internal {
                                                                                                                                                                            require(amount <= maxTxAmount, "Transaction limit exceeded (anti-dump)");
                                                                                                                                                                                    require(amount > 0, "Amount must be greater than zero");
                                                                                                                                                                                            require(recipient != address(0), "Recipient address cannot be zero");

                                                                                                                                                                                                    if (isExcludedFromTax[sender] || isExcludedFromTax[recipient]) {
                                                                                                                                                                                                                super._transfer(sender, recipient, amount);
                                                                                                                                                                                                                        } else {
                                                                                                                                                                                                                                    uint256 taxAmount = (amount * taxPercentage) / 100;
                                                                                                                                                                                                                                                uint256 sendAmount = amount - taxAmount;

                                                                                                                                                                                                                                                            // Деление налога: 2.5% на маркетинг и 2.5% на ликвидность
                                                                                                                                                                                                                                                                        uint256 halfTax = taxAmount / 2;
                                                                                                                                                                                                                                                                                    super._transfer(sender, marketingWallet, halfTax); 
                                                                                                                                                                                                                                                                                                super._transfer(sender, liquidityWallet, halfTax); 
                                                                                                                                                                                                                                                                                                            super._transfer(sender, recipient, sendAmount);
                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                        }

                                                                                                                                                                                                                                                                                                                            // Исключить адрес из налога
                                                                                                                                                                                                                                                                                                                                function excludeFromTax(address account) external onlyOwner {
                                                                                                                                                                                                                                                                                                                                        isExcludedFromTax[account] = true;
                                                                                                                                                                                                                                                                                                                                            }

                                                                                                                                                                                                                                                                                                                                                // Включить адрес в налог
                                                                                                                                                                                                                                                                                                                                                    function includeInTax(address account) external onlyOwner {
                                                                                                                                                                                                                                                                                                                                                            isExcludedFromTax[account] = false;
                                                                                                                                                                                                                                                                                                                                                                }

                                                                                                                                                                                                                                                                                                                                                                    // Установить новый процент налога
                                                                                                                                                                                                                                                                                                                                                                        function setTaxPercentage(uint256 newTax) external onlyOwner {
                                                                                                                                                                                                                                                                                                                                                                                require(newTax <= 5, "Tax cannot exceed 5%");
                                                                                                                                                                                                                                                                                                                                                                                        taxPercentage = newTax;
                                                                                                                                                                                                                                                                                                                                                                                            }

                                                                                                                                                                                                                                                                                                                                                                                                // Установить новый максимум суммы транзакции
                                                                                                                                                                                                                                                                                                                                                                                                    function setMaxTxAmount(uint256 newMax) external onlyOwner {
                                                                                                                                                                                                                                                                                                                                                                                                            require(newMax >= totalSupply() / 200, "Minimum limit is 0.5% of total supply");
                                                                                                                                                                                                                                                                                                                                                                                                                    maxTxAmount = newMax;
                                                                                                                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                                                                                                                        }
