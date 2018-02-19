Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:38327 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeBSPuh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Feb 2018 10:50:37 -0500
Date: Mon, 19 Feb 2018 16:50:23 +0100
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Message-ID: <20180219155023.GA27116@work.Speedport_W_724V_09011603_05_013>
References: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
 <1517691074-20306-4-git-send-email-liuxuenetmail@gmail.com>
 <b88344ed-aacc-df3a-6ef4-b9b95d0e704f@osg.samsung.com>
 <CAJuUDwsAUDEcUjw3=u8NrnOSqpbVd-xt4hQw=+r814FanBQLSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuUDwsAUDEcUjw3=u8NrnOSqpbVd-xt4hQw=+r814FanBQLSQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

Hello.

On Fri, 2018-02-16 at 00:10, Xue Liu wrote:
> Hello,
> 
> On 14 February 2018 at 16:56, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> > Hello.
> >
> >
> > On 02/03/2018 09:51 PM, Xue Liu wrote:
> >> Add driver source code of NXP MCR20A IEEE 802.15.4 transceiver device.
> >
> > A little bit more information on the device and driver would be good to
> get added here. :)
> >
> > Link to product page and data sheet for example.
> >
> OK. I will add more information.

Thanks.

> >> +
> >> +#define printdev(X) (&X->spi->dev)
> >
> > Why this macro?
> >
> >
> It is copied from mrf24j40.c. It is used in dev_dbg functions.

Hmm, I do not really see much of a benefit to using spi->dev instead but fair enough.


> >> +     hw->parent = &spi->dev;
> >> +     ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> >
> > Does the device have any permanent storage where a EUI64 could be saved
> over resets and reboots?
> >
> Unfortunately, there is no permanent storage in MCR20A

Pity, but just thje same like all the other cheap SPI mondules.

> > Did you test this driver against other transceivers? I should have a
> MCR20A on my table somewhere, but I have not hooked it up for testing yet.
> Yes. I summary my test environment here:
> 1. There patches are compiled but not tested against bluetooth-next
> <https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=255442c93843f52b6891b21d0b485bf2c97f93c3>source
> tree
> 2. This MCR20A device driver is tested on Raspberrypi with Linux kernel
> 4.15 and NXP FRDM-CR20A.
> 3. Test with wpan-ping program only with different packet sizes and time
> intervals.
> 4. The MCR20A is either server or client. On the other side, one ATUSB is
> running wpan-ping program, another ATUSB is working as monitor.

Great, that gives enougn of a testing for now. Thanks for explaining it.

regards
Stefan Schmidt
