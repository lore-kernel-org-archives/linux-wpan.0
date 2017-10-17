Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46579 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934778AbdJQJjs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Oct 2017 05:39:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id p87so955243pfj.3
        for <linux-wpan@vger.kernel.org>; Tue, 17 Oct 2017 02:39:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8a07285b-bba1-66d1-9fa0-5cd6fdae0ffd@datenfreihafen.org>
References: <1507648665-14932-1-git-send-email-liuxuenetmail@gmail.com> <8a07285b-bba1-66d1-9fa0-5cd6fdae0ffd@datenfreihafen.org>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 17 Oct 2017 11:39:47 +0200
Message-ID: <CAJuUDwvhcEYRZ3mYp2uXke0j1DNWdfkmYChVUted54O2DZPOuQ@mail.gmail.com>
Subject: Re: [PATCH] 802154:netlink - fix typo of the name of struct genl_ops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org

OK. got the style.

On 16 October 2017 at 22:14, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
> Hello
>
> On 10.10.2017 17:17, Xue Liu wrote:
>> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
>> ---
>>  net/ieee802154/netlink.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
>> index 6bde9e5..96636e3 100644
>> --- a/net/ieee802154/netlink.c
>> +++ b/net/ieee802154/netlink.c
>> @@ -89,7 +89,7 @@ int ieee802154_nl_reply(struct sk_buff *msg, struct genl_info *info)
>>       return genlmsg_reply(msg, info);
>>  }
>>
>> -static const struct genl_ops ieee8021154_ops[] = {
>> +static const struct genl_ops ieee802154_ops[] = {
>>       /* see nl-phy.c */
>>       IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
>>                       ieee802154_dump_phy),
>> @@ -137,8 +137,8 @@ struct genl_family nl802154_family __ro_after_init = {
>>       .version        = 1,
>>       .maxattr        = IEEE802154_ATTR_MAX,
>>       .module         = THIS_MODULE,
>> -     .ops            = ieee8021154_ops,
>> -     .n_ops          = ARRAY_SIZE(ieee8021154_ops),
>> +     .ops            = ieee802154_ops,
>> +     .n_ops          = ARRAY_SIZE(ieee802154_ops),
>>       .mcgrps         = ieee802154_mcgrps,
>>       .n_mcgrps       = ARRAY_SIZE(ieee802154_mcgrps),
>>  };
>>
>
> Applied to my wpan-next tree. It will be part of my next pull request to
> the net tree.
>
> I took the freedom to adjust the patch subject slightly to match our
> style:
> ieee802154: netlink: fix typo of the name of struct genl_ops
>
> regards
> Stefan Schmidt
