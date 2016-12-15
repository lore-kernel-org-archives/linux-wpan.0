Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbcLOLxN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 06:53:13 -0500
Date: Thu, 15 Dec 2016 03:50:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
Message-ID: <20161215115059.GA22750@kroah.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Stanislaw Gruszka <sgruszka@redhat.com>, Gustavo Padovan <gustavo@padovan.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, Luca Coelho <luciano.coelho@intel.com>, devel@driverdev.osuosl.org, Jakub Kicinski <kubakici@wp.pl>, Stefan Schmidt <stefan@osg.samsung.com>, linux-mediatek@lists.infradead.org, wil6210@qca.qualcomm.com, linux-arm-kernel@lists.infradead.org, Chris Snook <chris.snook@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Jay Cliburn <jcliburn@gmail.com>, linux-wpan@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Intel Linux Wireless <linuxwifi@intel.com>, Alexander Aring <aar@pengutronix.de>, Marcel Holtmann <marcel@holtmann.org>, Hante Meuleman <hante.meuleman@broadcom.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Kalle Valo <kvalo@codeaurora.org>, Franky Lin <franky.lin@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-wireless@vger.kernel.org, Maya Erez <qca_merez@qca.qualcomm.com>, linux-bluetooth@vger.kernel.org, Chaoming Li <chaoming_li@realsil.com.cn>, netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org, Vince Bridgers <vbridger@opensource.altera.com>, "David S. Miller" <davem@davemloft.net>, Larry Finger <Larry.Finger@lwfinger.net>

On Thu, Dec 15, 2016 at 07:15:30AM +0200, Michael S. Tsirkin wrote:
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
>  drivers/net/wireless/intersil/orinoco/Makefile            | 3 ---
>  drivers/net/wireless/mediatek/mt7601u/Makefile            | 2 --
>  drivers/net/wireless/realtek/rtlwifi/Makefile             | 2 --
>  drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192c/Makefile    | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192de/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192se/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723be/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723com/Makefile  | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/Makefile   | 2 --
>  drivers/net/wireless/ti/wl1251/Makefile                   | 2 --
>  drivers/net/wireless/ti/wlcore/Makefile                   | 2 --
>  drivers/staging/rtl8188eu/Makefile                        | 2 +-
>  drivers/staging/rtl8192e/Makefile                         | 2 --
>  drivers/staging/rtl8192e/rtl8192e/Makefile                | 2 --
>  net/bluetooth/Makefile                                    | 2 --
>  net/ieee802154/Makefile                                   | 2 --
>  net/mac80211/Makefile                                     | 2 +-
>  net/mac802154/Makefile                                    | 2 --
>  net/wireless/Makefile                                     | 2 --
>  38 files changed, 5 insertions(+), 68 deletions(-)

For drivers/staging:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
