Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55782 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHLUPx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Aug 2018 16:15:53 -0400
Subject: Re: [RFC/RFT, net-next, 00/17] net: Convert neighbor tables to
 per-namespace
References: <20180717120651.15748-1-dsahern@kernel.org>
 <dc9cd93c-61d4-dc8c-9ba1-cd8584908ba2@virtuozzo.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <988a697a-984c-8ca8-7846-e62feb4a4aec@gmail.com>
Date: Sun, 12 Aug 2018 11:37:06 -0600
MIME-Version: 1.0
In-Reply-To: <dc9cd93c-61d4-dc8c-9ba1-cd8584908ba2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>, dsahern@kernel.org, netdev@vger.kernel.org
Cc: nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com, stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com, saeedm@mellanox.com, alex.aring@gmail.com, linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/12/18 12:46 AM, Vasily Averin wrote:
> On 07/17/2018 03:06 PM, dsahern@kernel.org wrote:
>> From: David Ahern <dsahern@gmail.com>
>>
>> Nikita Leshenko reported that neighbor entries in one namespace can
>> evict neighbor entries in another. The problem is that the neighbor
>> tables have entries across all namespaces without separate accounting
>> and with global limits on when to scan for entries to evict.
>>
>> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
>> namespace and making the accounting and threshold limits per namespace.
> 
> Dear David,
> I prepared own patch set to fix this problem and found your one.
> It looks perfect for me, and I hope David Miller will merge it soon,
> however I have found a few drawbacks:
> 

Hi:

I just returned from an extended vacation. I will revive this topic in
the next few days.

Thanks for the comments. I will address in the next version.
