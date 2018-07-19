Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44411 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbeGSRzB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 19 Jul 2018 13:55:01 -0400
MIME-Version: 1.0
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com> <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
In-Reply-To: <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 19 Jul 2018 10:12:23 -0700
Message-ID: <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Network Developers <netdev@vger.kernel.org>, nikita.leshchenko@oracle.com, Roopa Prabhu <roopa@cumulusnetworks.com>, Stephen Hemminger <stephen@networkplumber.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, NetFilter <netfilter-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
>
> Chatting with Nikolay about this and he brought up a good corollary - ip
> fragmentation. It really is a similar problem in that memory is consumed
> as a result of packets received from an external entity. The ipfrag
> sysctls are per namespace with a limit that non-init_net namespaces can
> not set high_thresh > the current value of init_net. Potential memory
> consumed by fragments scales with the number of namespaces which is the
> primary concern with making neighbor tables per namespace.

Nothing new, already discussed:
https://marc.info/?l=linux-netdev&m=140391416215988&w=2

:)
