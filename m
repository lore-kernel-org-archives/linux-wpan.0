Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:38412
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754546AbcLORyP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 12:54:15 -0500
Subject: Re: [bug report] ieee802154: atusb: try to read permanent extended
 address from device
References: <20161212122819.GA10577@elgon.mountain>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <23a48661-3506-55a4-8974-fb384d018797@osg.samsung.com>
Date: Thu, 15 Dec 2016 18:43:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161212122819.GA10577@elgon.mountain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 12/12/16 13:28, Dan Carpenter wrote:
> Hello Stefan Schmidt,
>
> The patch 6cc33eba232c: "ieee802154: atusb: try to read permanent
> extended address from device" from Dec 5, 2016, leads to the
> following static checker warning:
>
> 	drivers/net/ieee802154/atusb.c:714 atusb_set_extended_addr()
> 	error: doing dma on the stack (buffer)
>
> drivers/net/ieee802154/atusb.c
>    698  static int atusb_set_extended_addr(struct atusb *atusb)
>    699  {
>    700          struct usb_device *usb_dev = atusb->usb_dev;
>    701          unsigned char buffer[IEEE802154_EXTENDED_ADDR_LEN];
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    702          __le64 extended_addr;
>    703          u64 addr;
>    704          int ret;
>    705
>    706          /* Firmware versions before 0.3 do not support the EUI64_READ command.
>    707           * Just use a random address and be done */
>    708          if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
>    709                  ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
>    710                  return 0;
>    711          }
>    712
>    713          /* Firmware is new enough so we fetch the address from EEPROM */
>    714          ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
>    715                                  ATUSB_EUI64_READ, ATUSB_REQ_FROM_DEV, 0, 0,
>    716                                  buffer, IEEE802154_EXTENDED_ADDR_LEN, 1000);
>                                         ^^^^^^
>
> Stack memory is not dma-able and this is especially important for 4.9
> and later kernels because of the virtually mapped stacks I believe?
>
>    717          if (ret < 0)
>    718                  dev_err(&usb_dev->dev, "failed to fetch extended address\n");
>    719
>    720          memcpy(&extended_addr, buffer, IEEE802154_EXTENDED_ADDR_LEN);
>    721          /* Check if read address is not empty and the unicast bit is set correctly */
>    722          if (!ieee802154_is_valid_extended_unicast_addr(extended_addr)) {
>    723                  dev_info(&usb_dev->dev, "no permanent extended address found, random address set\n");
>    724                  ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
>    725          } else {
>    726                  atusb->hw->phy->perm_extended_addr = extended_addr;
>    727                  addr = swab64((__force u64)atusb->hw->phy->perm_extended_addr);
>    728                  dev_info(&usb_dev->dev, "Read permanent extended address %8phC from device\n",
>    729                          &addr);
>    730          }
>    731
>    732          return ret;
>    733  }
>
> See these older warnings as well:
>
> drivers/net/ieee802154/atusb.c:123 atusb_read_reg() error: doing dma on the stack (&value)
> drivers/net/ieee802154/atusb.c:126 atusb_read_reg() error: uninitialized symbol 'value'.
> drivers/net/ieee802154/atusb.c:615 atusb_get_and_show_revision() error: doing dma on the stack (buffer)
> drivers/net/ieee802154/atusb.c:643 atusb_get_and_show_build() error: doing dma on the stack (build)
>

Just sent a patchset fixing those. Thanks for letting us know.

regards
Stefan Schmidt
