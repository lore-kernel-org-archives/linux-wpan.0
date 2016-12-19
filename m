Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:45316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753483AbcLSJJJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Dec 2016 04:09:09 -0500
Message-ID: <1482138490.26174.7.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
Date: Mon, 19 Dec 2016 11:08:10 +0200
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
         <1481778865-27667-9-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vince Bridgers <vbridger@opensource.altera.com>, Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Kalle Valo <kvalo@codeaurora.org>, Maya Erez <qca_merez@qca.qualcomm.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Stanislaw Gruszka <sgruszka@redhat.com>, Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Intel Linux Wireless <linuxwifi@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Larry Finger <Larry.Finger@lwfinger.net>, Chaoming Li <chaoming_li@realsil.com.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-wireless@vger.kernel.org, wil6210@qca.qualcomm.com, brcm80211-dev-list.pdl@broadcom.com, devel@driverdev.osuosl.org, linux-wpan@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

On Thu, 2016-12-15 at 07:15 +0200, Michael S. Tsirkin wrote:
> That's the default now, no need for makefiles to set it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/bluetooth/Makefile                                | 2 --
>  drivers/net/can/Makefile                                  | 1 -
>  drivers/net/ethernet/altera/Makefile                      | 1 -
>  drivers/net/ethernet/atheros/alx/Makefile                 | 1 -
>  drivers/net/ethernet/freescale/Makefile                   | 2 --
>  drivers/net/wireless/ath/Makefile                         | 2 --
>  drivers/net/wireless/ath/wil6210/Makefile                 | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile | 1 -
>  drivers/net/wireless/intel/iwlegacy/Makefile              | 2 --
>  drivers/net/wireless/intel/iwlwifi/Makefile               | 2 +-
>  drivers/net/wireless/intel/iwlwifi/dvm/Makefile           | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/Makefile           | 2 +-

For the drivers/net/wireless/intel/iwlwifi/ part:

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Luca.
