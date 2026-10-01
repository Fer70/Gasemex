
const { useState } = React;

    function QuantityControl({ id, cantidad }) {

        const [quantity, setQuantity] = useState(cantidad);
        const [loading, setLoading] = useState(false);

        async function updateQuantity(action) {

            if (loading) {
                return;
            }

            setLoading(true);

            try {

                const response = await fetch(
                    `products/api/carrito/${action}/${id}`,
                    {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }
                );

                const data = await response.json();

                if (!response.ok) {
                    throw new Error(
                        data.error || 'Error al actualizar el carrito'
                    );
                }

                if (data.eliminado) {

                    window.location.reload();

                    return;
                }

                setQuantity(data.cantidad);

                const row = document.querySelector(
                    `tr[data-product-id="${id}"]`
                );

                if (row) {

                    const subtotal =
                        row.querySelector('.product-subtotal');

                    if (subtotal) {

                        subtotal.textContent =
                            `$${data.subtotal.toFixed(2)}`;

                    }
                }

            } catch (error) {

                console.error(error);

                alert(
                    'No se pudo actualizar el carrito.'
                );

            } finally {

                setLoading(false);
            }
        }

        return React.createElement(
            React.Fragment,
            null,

            React.createElement(
                'button',
                {
                    type: 'button',
                    className:
                        'btn btn-outline-secondary btn-sm quantity-btn',
                    disabled: loading,
                    onClick: () =>
                        updateQuantity('disminuir')
                },
                React.createElement(
                    'i',
                    {
                        className: 'bi bi-dash-lg'
                    }
                )
            ),

            React.createElement(
                'span',
                {
                    className: 'mx-3'
                },
                quantity
            ),

            React.createElement(
                'button',
                {
                    type: 'button',
                    className:
                        'btn btn-outline-success btn-sm quantity-btn',
                    disabled: loading,
                    onClick: () =>
                        updateQuantity('aumentar')
                },
                React.createElement(
                    'i',
                    {
                        className: 'bi bi-plus-lg'
                    }
                )
            )
        );
    }


    document
    .querySelectorAll('.quantity-control')
    .forEach(element => {

        const id = element.dataset.id;

        const cantidad =
            parseInt(element.dataset.cantidad);

        ReactDOM
            .createRoot(element)
            .render(

                React.createElement(
                    QuantityControl,
                    {
                        id: id,
                        cantidad: cantidad
                    }
                )

            );

    });
