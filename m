Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38277 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQV5W (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Apr 2019 17:57:22 -0400
MIME-Version: 1.0
References: <20190417205404.1877560-1-arnd@arndb.de>
In-Reply-To: <20190417205404.1877560-1-arnd@arndb.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 17 Apr 2019 17:56:43 -0400
Message-ID: <CAF=yD-KkUveFFj_j721kML0rMJF=uDcVQv+RQO4N6xjorHCtZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] net: rework SIOCGSTAMP ioctl handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, y2038 Mailman List <y2038@lists.linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Neil Horman <nhorman@tuxdriver.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org

On Wed, Apr 17, 2019 at 4:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> socket protocol handlers, and all of those end up calling the same
> sock_get_timestamp()/sock_get_timestampns() helper functions, which
> results in a lot of duplicate code.
>
> With the introduction of 64-bit time_t on 32-bit architectures, this
> gets worse, as we then need four different ioctl commands in each
> socket protocol implementation.
>
> To simplify that, let's add a new .gettstamp() operation in
> struct proto_ops, and move ioctl implementation into the common
> sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> through.
>
> We can reuse the sock_get_timestamp() implementation, but generalize
> it so it can deal with both native and compat mode, as well as
> timeval and timespec structures.
>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Willem de Bruijn <willemb@google.com>
