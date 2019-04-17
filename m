Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43545 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfDQSRI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Apr 2019 14:17:08 -0400
MIME-Version: 1.0
References: <20190416203620.539628-1-arnd@arndb.de> <CAF=yD-K89Z2ea_iakjfP98GnfU-yXts8LU4GW3Rr_etJ+r92pw@mail.gmail.com>
 <CAK8P3a2z5QT7VooQPytx-C+Z_+kxzqmWmB8x-ow9PaApPuFY8g@mail.gmail.com>
In-Reply-To: <CAK8P3a2z5QT7VooQPytx-C+Z_+kxzqmWmB8x-ow9PaApPuFY8g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 17 Apr 2019 14:16:29 -0400
Message-ID: <CAF=yD-KCE46P4BniBXM_OgXL8hHwr4U-3hFxXRy70hBkbwY6Kg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Ralf Baechle <ralf@linux-mips.org>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Gerrit Renker <gerrit@erg.abdn.ac.uk>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Andrew Hendry <andrew.hendry@gmail.com>, Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org

On Wed, Apr 17, 2019 at 12:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Apr 17, 2019 at 4:46 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Tue, Apr 16, 2019 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> > > socket protocol handlers, and all of those end up calling the same
> > > sock_get_timestamp()/sock_get_timestampns() helper functions, which
> > > results in a lot of duplicate code.
> > >
> > > With the introduction of 64-bit time_t on 32-bit architectures, this
> > > gets worse, as we then need four different ioctl commands in each
> > > socket protocol implementation.
> > >
> > > To simplify that, let's add a new .gettstamp() operation in
> > > struct proto_ops, and move ioctl implementation into the common
> > > sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> > > through.
> > >
> > > We can reuse the sock_get_timestamp() implementation, but generalize
> > > it so it can deal with both native and compat mode, as well as
> > > timeval and timespec structures.
> > >
> > > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> > > Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > v2: reworked to not break sparc64 support
> >
> > From the discussion of v1 I thought you planned to unconditionally
> > call sock_gettstamp() for all protocols, avoiding the need to plumb in
> > all these new callbacks?
> >
> > That is more concise, though this closer to the existing behavior. So,
> > fine either way.
>
> Thanks for the reminder. I have definitely waited too long before revisiting
> this series, and only had a vague recollection of that discussion but could
> not find it in the logs (found it now, and the Link I quoted...).
>
> I would prefer to get this series into the coming merge window, and
> probably don't have time to rework it completely by then, so I hope
> the current version is ok.

Absolutely. This is a great simplification either way.

> I also found your comment on lock_sock(), which could be easily
> added inside of sock_gettstamp() if you think we should have that.

To remind, the issue is that sock_enable_timestamp should update both
sk_flags and net_enable_timestamp as one atomic operation, by holding
the socket lock. The lock is held when called from a setsockopt path.
And from some ioctl() implementations. The syzkaller reproducer
triggered through inet_release, so the most widely used paths are
buggy today.

Since the current state is inconsistent already, we can defer the fix.
I expect that it is now safe to add a lock around this logic without
triggering lockdep issues in any of the numerous paths. But just in
case, it still seems safer to do that in a separate patch that we can
revert or rework independent from this, if that would prove necessary.

> There is one more issue I just noticed (I dropped the necessary
> sock_read_timestamp()), so I have to repost the series anyway
> to fix that.

Instead of reading sk->sk_stamp directly? Yes, makes sense.
