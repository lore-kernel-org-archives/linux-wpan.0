Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43740 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQSRC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Jul 2018 14:17:02 -0400
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
References: <20180717120651.15748-1-dsahern@kernel.org>
 <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
Date: Tue, 17 Jul 2018 11:43:16 -0600
MIME-Version: 1.0
In-Reply-To: <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, nikita.leshchenko@oracle.com, Roopa Prabhu <roopa@cumulusnetworks.com>, Stephen Hemminger <stephen@networkplumber.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com, linux-wpan@vger.kernel.org, NetFilter <netfilter-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 7/17/18 11:40 AM, Cong Wang wrote:
> On Tue, Jul 17, 2018 at 5:11 AM <dsahern@kernel.org> wrote:
>>
>> From: David Ahern <dsahern@gmail.com>
>>
>> Nikita Leshenko reported that neighbor entries in one namespace can
>> evict neighbor entries in another. The problem is that the neighbor
>> tables have entries across all namespaces without separate accounting
>> and with global limits on when to scan for entries to evict.
> 
> It is nothing new, people including me already noticed this before.
> 
> 
>>
>> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
>> namespace and making the accounting and threshold limits per namespace.
> 
> 
> The last discussion about this a long time ago concluded that neigh
> table entries are controllable by remote, so after moving it to per netns,
> it would be easier to DOS the host.
> 

There are still limits on the total number of entries and with
per-namespace limits an admin has better control.
