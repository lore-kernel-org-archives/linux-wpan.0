Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbeGQSOE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Jul 2018 14:14:04 -0400
MIME-Version: 1.0
References: <20180717120651.15748-1-dsahern@kernel.org>
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 17 Jul 2018 10:40:09 -0700
Message-ID: <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: dsahern@kernel.org
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, nikita.leshchenko@oracle.com, Roopa Prabhu <roopa@cumulusnetworks.com>, Stephen Hemminger <stephen@networkplumber.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com, linux-wpan@vger.kernel.org, NetFilter <netfilter-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Ahern <dsahern@gmail.com>

On Tue, Jul 17, 2018 at 5:11 AM <dsahern@kernel.org> wrote:
>
> From: David Ahern <dsahern@gmail.com>
>
> Nikita Leshenko reported that neighbor entries in one namespace can
> evict neighbor entries in another. The problem is that the neighbor
> tables have entries across all namespaces without separate accounting
> and with global limits on when to scan for entries to evict.

It is nothing new, people including me already noticed this before.


>
> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
> namespace and making the accounting and threshold limits per namespace.


The last discussion about this a long time ago concluded that neigh
table entries are controllable by remote, so after moving it to per netns,
it would be easier to DOS the host.
