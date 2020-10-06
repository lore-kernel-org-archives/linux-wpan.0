Return-Path: <SRS0=NptA=DN=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4DAC41604
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Oct 2020 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B2D20760
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Oct 2020 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgJFOOT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:14:19 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:58240 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgJFOOT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Oct 2020 10:14:19 -0400
Received: from localhost.localdomain (p200300e9d72c3c4353f06c511a49ff67.dip0.t-ipconnect.de [IPv6:2003:e9:d72c:3c43:53f0:6c51:1a49:ff67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 01E43C257F;
        Tue,  6 Oct 2020 16:14:14 +0200 (CEST)
Subject: Re: [PATCH v5 25/52] docs: net: ieee802154.rst: fix C expressions
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
 <6ba1d137516e4a144a4fd398934d62b94d31446d.1601992016.git.mchehab+huawei@kernel.org>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <797b0cbc-5586-ae4a-6967-ec99b6554879@datenfreihafen.org>
Date:   Tue, 6 Oct 2020 16:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6ba1d137516e4a144a4fd398934d62b94d31446d.1601992016.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

[Sorry for the earlier empty mail]

On 06.10.20 16:03, Mauro Carvalho Chehab wrote:
> There are some warnings produced with Sphinx 3.x:
> 
> 	Documentation/networking/ieee802154.rst:29: WARNING: Error in declarator or parameters
> 	Invalid C declaration: Expecting "(" in parameters. [error at 7]
> 	  int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
> 	  -------^
> 	Documentation/networking/ieee802154.rst:134: WARNING: Invalid C declaration: Expected end of definition. [error at 81]
> 	  void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi):
> 	  ---------------------------------------------------------------------------------^
> 	Documentation/networking/ieee802154.rst:139: WARNING: Invalid C declaration: Expected end of definition. [error at 95]
> 	  void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb, bool ifs_handling):
> 	  -----------------------------------------------------------------------------------------------^
> 	Documentation/networking/ieee802154.rst:158: WARNING: Invalid C declaration: Expected end of definition. [error at 35]
> 	  int start(struct ieee802154_hw *hw):
> 	  -----------------------------------^
> 	Documentation/networking/ieee802154.rst:162: WARNING: Invalid C declaration: Expected end of definition. [error at 35]
> 	  void stop(struct ieee802154_hw *hw):
> 	  -----------------------------------^
> 	Documentation/networking/ieee802154.rst:166: WARNING: Invalid C declaration: Expected end of definition. [error at 61]
> 	  int xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb):
> 	  -------------------------------------------------------------^
> 	Documentation/networking/ieee802154.rst:171: WARNING: Invalid C declaration: Expected end of definition. [error at 43]
> 	  int ed(struct ieee802154_hw *hw, u8 *level):
> 	  -------------------------------------------^
> 	Documentation/networking/ieee802154.rst:176: WARNING: Invalid C declaration: Expected end of definition. [error at 62]
> 	  int set_channel(struct ieee802154_hw *hw, u8 page, u8 channel):
> 	  --------------------------------------------------------------^
> 
> Caused by some bad c:function: prototypes. Fix them.
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/networking/ieee802154.rst | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)


Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
