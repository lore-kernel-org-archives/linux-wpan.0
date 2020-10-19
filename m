Return-Path: <SRS0=TmWs=D2=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10FC433E7
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75962231B
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2pt81Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgJSTyn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJSTyn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Oct 2020 15:54:43 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8CC0613CE
        for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2020 12:54:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t15so894849otk.0
        for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2020 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+VJc2xko6YvPJVgam3m+B945+c2X6E9AXAeVYRoSWs=;
        b=B2pt81MpRkhL86iNCJj2iO8OlUj0NBPksKhn6bj55fvV4+34mbdmRrW+YDTp/xM8Pw
         D9fLLs3Zza6r8M7MYjlh8c06sojUTcZzfmjVu8Ji8h08BBD+1R010eYVm0bzno1xtZkR
         Pr1Ar/2+caSZ0NkDsX8Nj/ABx050m7zwNWKBeSxjC74L9HGVf5135WZSdy4k8de85MCQ
         Hdvz5GA/py3quN0or2OhjnA6udgqHmAHuqpiRtZccrDvhg9jSGZu7e8cfjNht20qbaRn
         jWpU35muDTBMggVcoeaNIKsjHGMXiuZOTKlNB+tqdgjTMwDZLOz8d5Tb5fdKZ6PxrVGS
         p+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+VJc2xko6YvPJVgam3m+B945+c2X6E9AXAeVYRoSWs=;
        b=dokAL1EtA8vDbdGIy9UTgRI35yZl1U7EV2XkxdsN0lHUmN+yrdKmVAPjQFvpwNf0Pg
         h6ZonoK3LJdBZLKkYmIrifsrarjlJd65JHJizJrljeLYm1CyHZM/0F2guKVmNFgqvghe
         Ss6HzQRYc10tWFsV+xE1AEzd/8sNnPLxAjKbT9jDogK/JmlNxe1VOcnPiwQYeA3SJQE5
         VxkqTTZ6tEqfPrOq5U3XUHwqoqvOAg8B9H5FkG4pyKGmmhM75VOsN9jGZV1g0J2oSYyB
         OsN1uYE8S4F6PBkcelMgCt6T6JdHIwey2YO1zUfpQ5s7qJjtcuV20JNPLYY/zgWfw5oV
         TrMA==
X-Gm-Message-State: AOAM53006kwj7Y7kkNmdChdWetzdcLfAyAzMrf7ia+cCMpzotNndk6do
        kh/7LG3vRFpxNtuNMY/LA2LQqvmwxjeKeoecj1AZdIGzMr8=
X-Google-Smtp-Source: ABdhPJyLquo7RNGM+3ACXMlmlVHvoW1kAlRu+dhaWGeBbrfEoLclQGxxQps6H6e8pL7RqaJzHzwPRDHHaShAurmzvP4=
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr1131510otb.183.1603137281971;
 Mon, 19 Oct 2020 12:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201018170934.2c03c9e3@rechenknecht2k11> <CAB_54W5VgY+DeqdjiQ7BJsmXw-G=POwGE7tzYuwAwYixe6y9XQ@mail.gmail.com>
 <20201019080711.3f070beb@rechenknecht2k11>
In-Reply-To: <20201019080711.3f070beb@rechenknecht2k11>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Mon, 19 Oct 2020 15:54:30 -0400
Message-ID: <CAB_54W5neFEzFGV=1v_AD4OSYs1qw=YjkoM-FeUkSyHjJ3owtA@mail.gmail.com>
Subject: Re: iwpan with LLSEC - attribute type 1 has an invalid length
To:     Benjamin Valentin <benjamin.valentin@ml-pa.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>, koen@bergzand.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, 19 Oct 2020 at 02:07, Benjamin Valentin
<benjamin.valentin@ml-pa.com> wrote:
>
> On Sun, 18 Oct 2020 19:20:53 -0400
> Alexander Aring <alex.aring@gmail.com> wrote:
>
> > 2 is ack frame, I think you mean 1.
>
> Same error with 1
>
> > Success? Like above? Can you tell me the command line error message
> > please? What does tell you "type 1 has an invalid length"
>
> dmesg tells me that when I enter that command:
>
> [  156.899429] netlink: 'iwpan': attribute type 1 has an invalid length.

There are recent changes to netlink to "validate" more netlink policy
and I think we are doing it wrong in kernel or user.

Try wpan-tools:

diff --git a/src/security.c b/src/security.c
index 1659699..8062608 100644
--- a/src/security.c
+++ b/src/security.c
@@ -299,7 +299,7 @@ static int print_seclevel_handler(struct nl_msg
*msg, void *arg)
        if (tb[NL802154_ATTR_SEC_LEVEL]) {
                struct nlattr *tb_seclevel[NL802154_SECLEVEL_ATTR_MAX + 1];
                static struct nla_policy
seclevel_policy[NL802154_SECLEVEL_ATTR_MAX + 1] = {
-                       [NL802154_SECLEVEL_ATTR_LEVELS] = { .type = NLA_U32 },
+                       [NL802154_SECLEVEL_ATTR_LEVELS] = { .type = NLA_U8 },
                        [NL802154_SECLEVEL_ATTR_FRAME] = { .type = NLA_U32 },
                        [NL802154_SECLEVEL_ATTR_CMD_FRAME] = { .type =
NLA_U32 },
                        [NL802154_SECLEVEL_ATTR_DEV_OVERRIDE] = {
.type = NLA_U8 },
@@ -400,7 +400,7 @@ static int handle_seclevel_add(struct
nl802154_state *state, struct nl_cb *cb,
        if (!seclevel_msg)
                return -ENOMEM;

-       NLA_PUT_U32(seclevel_msg, NL802154_SECLEVEL_ATTR_LEVELS, levels);
+       NLA_PUT_U8(seclevel_msg, NL802154_SECLEVEL_ATTR_LEVELS, levels);
        NLA_PUT_U32(seclevel_msg, NL802154_SECLEVEL_ATTR_FRAME, frame);
        if (frame == NL802154_FRAME_CMD)
                NLA_PUT_U32(seclevel_msg,
NL802154_SECLEVEL_ATTR_CMD_FRAME, cmd_id);


That should fix it.

> So I assume that's why encryption fails.
>
> >  - Don't trust wireshark, you will not see exactly what's sending out
> > on the wire. We just do the encryption on the wrong layer, but moving
> > it was causing other problems. I recently stumbled over something
> > which maybe can help us there, but didn't look closely at that, some
> > subsystems have special handling for tcpdump/wireshark things.
>
> Would that cause interoperability issues with other implementations?
>

No, just use a monitor interface to see what the on air traffic is.
Don't trust local captures.

- Alex
