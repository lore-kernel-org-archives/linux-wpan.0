Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:56573 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdAPLrO (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 16 Jan 2017 06:47:14 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH v7 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20170110154122.6724-1-h.morris@cascoda.com>
 <20170110154122.6724-2-h.morris@cascoda.com>
 <84e02f0a-9b85-888e-be2a-d9d72fd7b7a0@pengutronix.de>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <02d9d99c-5cb7-2bfe-6140-5eef3d93ccc6@cascoda.com>
Date: Mon, 16 Jan 2017 11:47:07 +0000
MIME-Version: 1.0
In-Reply-To: <84e02f0a-9b85-888e-be2a-d9d72fd7b7a0@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org, stefan@osg.samsung.com, marcel@holtmann.org

Hi Alex,

On 14/01/2017 17:13, Alexander Aring wrote:
> Hi,
>
> On 01/10/2017 04:41 PM, Harry Morris wrote:
>> <snip>
>> +
>> +	if (ca8210_spi_transfer(
>> +		device_ref, &command.command_id, command.length + 2)
>> +	)
> code style here? Did you run checkpatch?
checkpatch didn't throw up any complaints regarding style - from what I 
can see the kernel guidelines are fairly flexible when it comes to 
splitting long lines. I'm totally happy to newline each argument or 
something though eg.

if (ca8210_spi_transfer(
	device_ref,
	&command.command_id
	command.length + 2)
)

>> +		return MAC_SYSTEM_ERROR;
>> +
>> +	return MAC_SUCCESS;
>> +}
>> +
>> +/**
>> + * mlme_reset_request_sync() - MLME_RESET_request/confirm according to API Spec
>> + * @set_default_pib: Set defaults in PIB
>> + * @device_ref:      Nondescript pointer to target device
>> + *
>> + * Return: 802.15.4 status code of MLME-RESET.confirm
>> + */
>> +static u8 mlme_reset_request_sync(
>> +	u8    set_default_pib,
>> +	void *device_ref
>> +)
>> +{
>> +	u8 status;
>> +	struct mac_message command, response;
>> +	struct spi_device *spi = device_ref;
>> +
>> +	command.command_id = SPI_MLME_RESET_REQUEST;
>> +	command.length = 1;
>> +	command.pdata.u8param = set_default_pib;
>> +
>> +	if (cascoda_api_downstream(
>> +		&command.command_id,
>> +		command.length + 2,
>> +		&response.command_id,
>> +		device_ref)) {
>> +		dev_err(&spi->dev, "cascoda_api_downstream failed\n");
>> +		return MAC_SYSTEM_ERROR;
>> +	}
>> +
>> +	if (response.command_id != SPI_MLME_RESET_CONFIRM)
>> +		return MAC_SYSTEM_ERROR;
>> +
>> +	status = response.pdata.status;
>> +
>> +	/* reset COORD Bit for Channel Filtering as Coordinator */
>> +	if (CA8210_MAC_WORKAROUNDS && set_default_pib && (!status)) {
>> +		status = tdme_setsfr_request_sync(
>> +			0,
>> +			CA8210_SFR_MACCON,
>> +			0,
>> +			device_ref
>> +		);
>> +	}
>> +
>> +	return status;
>> +}
>> +
>> +/**
>> + * mlme_set_request_sync() - MLME_SET_request/confirm according to API Spec
>> + * @pib_attribute:        Attribute Number
>> + * @pib_attribute_index:  Index within Attribute if an Array
>> + * @pib_attribute_length: Attribute length
>> + * @pib_attribute_value:  Pointer to Attribute Value
>> + * @device_ref:           Nondescript pointer to target device
>> + *
>> + * Return: 802.15.4 status code of MLME-SET.confirm
>> + */
>> +static u8 mlme_set_request_sync(
>> +	u8            pib_attribute,
>> +	u8            pib_attribute_index,
>> +	u8            pib_attribute_length,
>> +	const void   *pib_attribute_value,
>> +	void         *device_ref
>> +)
>> +{
>> +	u8 status;
>> +	struct mac_message command, response;
>> +
>> +	/* pre-check the validity of pib_attribute values that are not checked
>> +	 * in MAC
>> +	 */
>> +	if (tdme_checkpibattribute(
>> +		pib_attribute, pib_attribute_length, pib_attribute_value)) {
>> +		return MAC_INVALID_PARAMETER;
>> +	}
>> +
>> +	if (pib_attribute == PHY_CURRENT_CHANNEL) {
>> +		status = tdme_channelinit(
>> +			*((u8 *)pib_attribute_value),
>> +			device_ref
>> +		);
>> +		if (status)
>> +			return status;
>> +	}
>> +
>> +	if (pib_attribute == PHY_TRANSMIT_POWER) {
>> +		return tdme_settxpower(
>> +			*((u8 *)pib_attribute_value),
>> +			device_ref
>> +		);
>> +	}
>> +
>> +	command.command_id = SPI_MLME_SET_REQUEST;
>> +	command.length = sizeof(struct mlme_set_request_pset) -
>> +		MAX_ATTRIBUTE_SIZE + pib_attribute_length;
>> +	command.pdata.set_req.pib_attribute = pib_attribute;
>> +	command.pdata.set_req.pib_attribute_index = pib_attribute_index;
>> +	command.pdata.set_req.pib_attribute_length = pib_attribute_length;
>> +	memcpy(
>> +		command.pdata.set_req.pib_attribute_value,
>> +		pib_attribute_value,
>> +		pib_attribute_length
>> +	);
>> +
>> +	if (cascoda_api_downstream(
>> +		&command.command_id,
>> +		command.length + 2,
>> +		&response.command_id,
>> +		device_ref)) {
>> +		return MAC_SYSTEM_ERROR;
>> +	}
>> +
>> +	if (response.command_id != SPI_MLME_SET_CONFIRM)
>> +		return MAC_SYSTEM_ERROR;
>> +
>> +	return response.pdata.status;
>> +}
>> +
>> +/**
>> + * hwme_set_request_sync() - HWME_SET_request/confirm according to API Spec
>> + * @hw_attribute:        Attribute Number
>> + * @hw_attribute_length: Attribute length
>> + * @hw_attribute_value:  Pointer to Attribute Value
>> + * @device_ref:          Nondescript pointer to target device
>> + *
>> + * Return: 802.15.4 status code of HWME-SET.confirm
>> + */
>> +static u8 hwme_set_request_sync(
>> +	u8           hw_attribute,
>> +	u8           hw_attribute_length,
>> +	u8          *hw_attribute_value,
>> +	void        *device_ref
>> +)
>> +{
>> +	struct mac_message command, response;
>> +
>> +	command.command_id = SPI_HWME_SET_REQUEST;
>> +	command.length = 2 + hw_attribute_length;
>> +	command.pdata.hwme_set_req.hw_attribute = hw_attribute;
>> +	command.pdata.hwme_set_req.hw_attribute_length = hw_attribute_length;
>> +	memcpy(
>> +		command.pdata.hwme_set_req.hw_attribute_value,
>> +		hw_attribute_value,
>> +		hw_attribute_length
>> +	);
>> +
>> +	if (cascoda_api_downstream(
>> +		&command.command_id,
>> +		command.length + 2,
>> +		&response.command_id,
>> +		device_ref)) {
>> +		return MAC_SYSTEM_ERROR;
>> +	}
>> +
>> +	if (response.command_id != SPI_HWME_SET_CONFIRM)
>> +		return MAC_SYSTEM_ERROR;
>> +
>> +	return response.pdata.hwme_set_cnf.status;
>> +}
>> +
>> +/**
>> + * hwme_get_request_sync() - HWME_GET_request/confirm according to API Spec
>> + * @hw_attribute:        Attribute Number
>> + * @hw_attribute_length: Attribute length
>> + * @hw_attribute_value:  Pointer to Attribute Value
>> + * @device_ref:          Nondescript pointer to target device
>> + *
>> + * Return: 802.15.4 status code of HWME-GET.confirm
>> + */
>> +static u8 hwme_get_request_sync(
>> +	u8           hw_attribute,
>> +	u8          *hw_attribute_length,
>> +	u8          *hw_attribute_value,
>> +	void        *device_ref
>> +)
>> +{
>> +	struct mac_message command, response;
>> +
>> +	command.command_id = SPI_HWME_GET_REQUEST;
>> +	command.length = 1;
>> +	command.pdata.hwme_get_req.hw_attribute = hw_attribute;
>> +
>> +	if (cascoda_api_downstream(
>> +		&command.command_id,
>> +		command.length + 2,
>> +		&response.command_id,
>> +		device_ref)) {
>> +		return MAC_SYSTEM_ERROR;
>> +	}
>> +
>> +	if (response.command_id != SPI_HWME_GET_CONFIRM)
>> +		return MAC_SYSTEM_ERROR;
>> +
>> +	if (response.pdata.hwme_get_cnf.status == MAC_SUCCESS) {
>> +		*hw_attribute_length =
>> +			response.pdata.hwme_get_cnf.hw_attribute_length;
>> +		memcpy(
>> +			hw_attribute_value,
>> +			response.pdata.hwme_get_cnf.hw_attribute_value,
>> +			*hw_attribute_length
>> +		);
>> +	}
>> +
>> +	return response.pdata.hwme_get_cnf.status;
>> +}
>> +
>> +/* Network driver operation */
>> +
>> +/**
>> + * ca8210_async_xmit_complete() - Called to announce that an asynchronous
>> + *                                transmission has finished
>> + * @hw:          ieee802154_hw of ca8210 that has finished exchange
>> + * @msduhandle:  Identifier of transmission that has completed
>> + * @status:      Returned 802.15.4 status code of the transmission
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_async_xmit_complete(
>> +	struct ieee802154_hw  *hw,
>> +	u8                     msduhandle,
>> +	u8                     status)
>> +{
>> +	struct ca8210_priv *priv = hw->priv;
>> +
>> +	if (priv->nextmsduhandle != msduhandle) {
>> +		dev_err(
>> +			&priv->spi->dev,
>> +			"Unexpected msdu_handle on data confirm, Expected %d, got %d\n",
>> +			priv->nextmsduhandle,
>> +			msduhandle
>> +		);
>> +		return -EIO;
>> +	}
>> +
>> +	/* stop timeout work */
>> +	if (!cancel_delayed_work_sync(&priv->async_tx_timeout_work)) {
>> +		dev_err(
>> +			&priv->spi->dev,
>> +			"async tx timeout wasn't pending when transfer complete\n"
>> +		);
>> +	}
>> +
>> +	priv->async_tx_pending = false;
>> +	priv->nextmsduhandle++;
>> +
>> +	if (status) {
>> +		dev_err(
>> +			&priv->spi->dev,
>> +			"Link transmission unsuccessful, status = %d\n",
>> +			status
>> +		);
>> +		if (status != MAC_TRANSACTION_OVERFLOW) {
>> +			ieee802154_wake_queue(priv->hw);
>> +			return 0;
>> +		}
>> +	}
>> +	ieee802154_xmit_complete(priv->hw, priv->tx_skb, true);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ca8210_skb_rx() - Contructs a properly framed socket buffer from a received
>> + *                   MCPS_DATA_indication
>> + * @hw:        ieee802154_hw that MCPS_DATA_indication was received by
>> + * @len:       length of MCPS_DATA_indication
>> + * @data_ind:  Octet array of MCPS_DATA_indication
>> + *
>> + * Called by the spi driver whenever a SAP command is received, this function
>> + * will ascertain whether the command is of interest to the network driver and
>> + * take necessary action.
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_skb_rx(
>> +	struct ieee802154_hw  *hw,
>> +	size_t                 len,
>> +	u8                    *data_ind
>> +)
>> +{
>> +	struct ieee802154_hdr hdr;
>> +	int msdulen;
>> +	int hlen;
>> +	struct sk_buff *skb;
>> +	struct ca8210_priv *priv = hw->priv;
>> +
>> +	/* Allocate mtu size buffer for every rx packet */
>> +	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
>> +	if (!skb) {
>> +		dev_crit(&priv->spi->dev, "dev_alloc_skb failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	skb_reserve(skb, sizeof(hdr));
>> +
>> +	msdulen = data_ind[22]; /* msdu_length */
>> +	if (msdulen > IEEE802154_MTU) {
>> +		dev_err(
>> +			&priv->spi->dev,
>> +			"received erroneously large msdu length!\n"
>> +		);
>> +		kfree_skb(skb);
>> +		return -EMSGSIZE;
>> +	}
>> +	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
>> +
>> +	/* Populate hdr */
>> +	hdr.sec.level = data_ind[29 + msdulen];
>> +	dev_dbg(&priv->spi->dev, "security level: %#03x\n", hdr.sec.level);
>> +	if (hdr.sec.level > 0) {
>> +		hdr.sec.key_id_mode = data_ind[30 + msdulen];
>> +		memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
>> +		hdr.sec.key_id = data_ind[39 + msdulen];
>> +	}
>> +	hdr.source.mode = data_ind[0];
>> +	dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
>> +	hdr.source.pan_id = *(u16 *)&data_ind[1];
>> +	dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
>> +	memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
>> +	hdr.dest.mode = data_ind[11];
>> +	dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
>> +	hdr.dest.pan_id = *(u16 *)&data_ind[12];
>> +	dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
>> +	memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
>> +
>> +	/* Fill in FC implicitly */
>> +	hdr.fc.type = 1; /* Data frame */
>> +	if (hdr.sec.level)
>> +		hdr.fc.security_enabled = 1;
>> +	else
>> +		hdr.fc.security_enabled = 0;
>> +	if (data_ind[1] != data_ind[12] || data_ind[2] != data_ind[13])
>> +		hdr.fc.intra_pan = 1;
>> +	else
>> +		hdr.fc.intra_pan = 0;
>> +	hdr.fc.dest_addr_mode = hdr.dest.mode;
>> +	hdr.fc.source_addr_mode = hdr.source.mode;
>> +
>> +	/* Add hdr to front of buffer */
>> +	hlen = ieee802154_hdr_push(skb, &hdr);
>> +
>> +	if (hlen < 0) {
>> +		dev_crit(&priv->spi->dev, "failed to push mac hdr onto skb!\n");
>> +		kfree_skb(skb);
>> +		return hlen;
>> +	}
>> +
>> +	skb_reset_mac_header(skb);
>> +	skb->mac_len = hlen;
>> +
>> +	/* Add <msdulen> bytes of space to the back of the buffer */
>> +	/* Copy msdu to skb */
>> +	memcpy(skb_put(skb, msdulen), &data_ind[29], msdulen);
>> +
>> +	ieee802154_rx_irqsafe(hw, skb, data_ind[23]/*LQI*/);
>> +	/* TODO: Set protocol & checksum? */
>> +	/* TODO: update statistics */
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ca8210_net_rx() - Acts upon received SAP commands relevant to the network
>> + *                   driver
>> + * @hw:       ieee802154_hw that command was received by
>> + * @command:  Octet array of received command
>> + * @len:      length of the received command
>> + *
>> + * Called by the spi driver whenever a SAP command is received, this function
>> + * will ascertain whether the command is of interest to the network driver and
>> + * take necessary action.
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
>> +{
>> +	struct ca8210_priv *priv = hw->priv;
>> +	unsigned long flags;
>> +	u8 status;
>> +
>> +	dev_dbg(&priv->spi->dev, "ca8210_net_rx(), CmdID = %d\n", command[0]);
>> +
>> +	if (command[0] == SPI_MCPS_DATA_INDICATION) {
>> +		/* Received data */
>> +		spin_lock_irqsave(&priv->lock, flags);
>> +		if (command[26] == priv->last_dsn) {
>> +			dev_dbg(
>> +				&priv->spi->dev,
>> +				"DSN %d resend received, ignoring...\n",
>> +				command[26]
>> +			);
>> +			spin_unlock_irqrestore(&priv->lock, flags);
>> +			return 0;
>> +		}
>> +		priv->last_dsn = command[26];
>> +		spin_unlock_irqrestore(&priv->lock, flags);
>> +		return ca8210_skb_rx(hw, len - 2, command + 2);
>> +	} else if (command[0] == SPI_MCPS_DATA_CONFIRM) {
>> +		status = command[3];
>> +		if (priv->async_tx_pending) {
>> +			return ca8210_async_xmit_complete(
>> +				hw,
>> +				command[2],
>> +				status
>> +			);
>> +		} else if (priv->sync_tx_pending) {
>> +			priv->sync_tx_pending = false;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ca8210_skb_tx() - Transmits a given socket buffer using the ca8210
>>
>> + * @skb:         Socket buffer to transmit
>> + * @msduhandle:  Data identifier to pass to the 802.15.4 MAC
>> + * @priv:        Pointer to private data section of target ca8210
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_skb_tx(
>> +	struct sk_buff      *skb,
>> +	u8                   msduhandle,
>> +	struct ca8210_priv  *priv
>> +)
>> +{
>> +	int status;
>> +	struct ieee802154_hdr header = { 0 };
>> +	struct secspec secspec;
>> +	unsigned int mac_len;
>> +
>> +	dev_dbg(&priv->spi->dev, "ca8210_skb_tx() called\n");
>> +
>> +	/* Get addressing info from skb - ieee802154 layer creates a full
>> +	 * packet
>> +	 */
>> +	mac_len = ieee802154_hdr_peek_addrs(skb, &header);
>> +
>> +	secspec.security_level = header.sec.level;
>> +	secspec.key_id_mode = header.sec.key_id_mode;
>> +	if (secspec.key_id_mode == 2)
>> +		memcpy(secspec.key_source, &header.sec.short_src, 4);
>> +	else if (secspec.key_id_mode == 3)
>> +		memcpy(secspec.key_source, &header.sec.extended_src, 8);
>> +	secspec.key_index = header.sec.key_id;
>> +
>> +	/* Pass to Cascoda API */
>> +	status =  mcps_data_request(
>> +		header.source.mode,
>> +		header.dest.mode,
>> +		header.dest.pan_id,
>> +		(union macaddr *)&header.dest.extended_addr,
>> +		skb->len - mac_len,
>> +		&skb->data[mac_len],
>> +		msduhandle,
>> +		header.fc.ack_request,
>> +		&secspec,
>> +		priv->spi
>> +	);
>> +	return link_to_linux_err(status);
>> +}
>> +
>> +/**
>> + * ca8210_async_tx_timeout_worker() - Executed when an asynchronous transmission
>> + *                                    times out
>> + * @work:  Work being executed
>> + */
>> +static void ca8210_async_tx_timeout_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *del_work = container_of(
>> +		work,
>> +		struct delayed_work,
>> +		work
>> +	);
>> +	struct ca8210_priv *priv = container_of(
>> +		del_work,
>> +		struct ca8210_priv,
>> +		async_tx_timeout_work
>> +	);
>> +	unsigned long flags;
>> +
>> +	dev_err(&priv->spi->dev, "data confirm timed out\n");
>> +
>> +	spin_lock_irqsave(&priv->lock, flags);
>> +
>> +	priv->async_tx_pending = false;
>> +
>> +	spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> +	ieee802154_wake_queue(priv->hw);
>> +}
>> +
>> +/**
>> + * ca8210_start() - Starts the network driver
>> + * @hw:  ieee802154_hw of ca8210 being started
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_start(struct ieee802154_hw *hw)
>> +{
>> +	int status;
>> +	u8 rx_on_when_idle;
>> +	struct ca8210_priv *priv = hw->priv;
>> +
>> +	priv->async_tx_workqueue = alloc_ordered_workqueue(
>> +		"ca8210 tx worker",
>> +		0
>> +	);
>> +	if (!priv->async_tx_workqueue) {
>> +		dev_crit(&priv->spi->dev, "alloc_ordered_workqueue failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	INIT_DELAYED_WORK(
>> +		&priv->async_tx_timeout_work,
>> +		ca8210_async_tx_timeout_worker
>> +	);
>> +
>> +	priv->last_dsn = -1;
>> +	/* Turn receiver on when idle for now just to test rx */
>> +	rx_on_when_idle = 1;
>> +	status = mlme_set_request_sync(
>> +		MAC_RX_ON_WHEN_IDLE,
>> +		0,
>> +		1,
>> +		&rx_on_when_idle,
>> +		priv->spi
>> +	);
>> +	if (status) {
>> +		dev_crit(
>> +			&priv->spi->dev,
>> +			"Setting rx_on_when_idle failed, status = %d\n",
>> +			status
>> +		);
>> +		return link_to_linux_err(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ca8210_stop() - Stops the network driver
>> + * @hw:  ieee802154_hw of ca8210 being stopped
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static void ca8210_stop(struct ieee802154_hw *hw)
>> +{
>> +	struct ca8210_priv *priv = hw->priv;
>> +
>> +	flush_workqueue(priv->async_tx_workqueue);
>> +	destroy_workqueue(priv->async_tx_workqueue);
>> +}
>> +
>> +/**
>> + * ca8210_xmit_async() - Asynchronously transmits a given socket buffer using
>> + *                       the ca8210
>> + * @hw:   ieee802154_hw of ca8210 to transmit from
>> + * @skb:  Socket buffer to transmit
>> + *
>> + * Return: 0 or linux error code
>> + */
>> +static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>> +{
>> +	struct ca8210_priv *priv = hw->priv;
>> +	int status;
>> +
>> +	dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
>> +
>> +	priv->tx_skb = skb;
>> +	priv->async_tx_pending = true;
>> +	status = ca8210_skb_tx(skb, priv->nextmsduhandle, priv);
>> +	queue_delayed_work(
>> +		priv->async_tx_workqueue,
>> +		&priv->async_tx_timeout_work,
>> +		msecs_to_jiffies(CA8210_DATA_CNF_TIMEOUT)
>> +	);
>> +	return status;
>> +}
> I thought you fixed now to use spi_async here. Do not a context switch
> here to a workqueue.
> You need to run spi_async which is allowed in non sleeping context.
So the workqueue here is for the /timeout/ work, not the actual 
transmission. I'm first calling ca8210_skb_tx which is calling spi_async 
further down, then using the workqueue to schedule a timeout if the 
MCPS-DATA.confirm is not received in a reasonable time. I'm aware that 
the stack will have its own timeout if xmit_complete is not called but 
this identifies the problem more specifically. I guess I can remove it 
if it seems like a bad idea.

> <snip>
>> +
>> +static struct spi_driver ca8210_spi_driver = {
>> +	.driver = {
>> +		.name =                 DRIVER_NAME,
>> +		.owner =                THIS_MODULE,
>> +		.of_match_table =       of_match_ptr(ca8210_of_ids),
>> +	},
>> +	.probe  =                       ca8210_probe,
>> +	.remove =                       ca8210_remove
>> +};
>> +
>> +static int __init ca8210_init(void)
>> +{
>> +	pr_info("Starting module ca8210\n");
>> +
>> +	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS))
>> +		cascoda_api_upstream = ca8210_test_int_driver_write;
>> +	else
>> +		cascoda_api_upstream = NULL;
>> +
>> +	spi_register_driver(&ca8210_spi_driver);
>> +	pr_info("ca8210 module started\n");
>> +	return 0;
>> +}
>> +module_init(ca8210_init);
>> +
>> +static void __exit ca8210_exit(void)
>> +{
>> +	pr_info("Stopping module ca8210\n");
>> +	spi_unregister_driver(&ca8210_spi_driver);
>> +	pr_info("ca8210 module stopped\n");
>> +}
>> +module_exit(ca8210_exit);
> why not module_spi_driver to spi_driver like _all_ other drivers?
> Debugfs can be created at probe functionality.
Yep, my bad I never noticed that helper before, I can definitely use that.

Regards,
Harry
