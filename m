Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36120 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbJBHUL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Oct 2015 03:20:11 -0400
Received: by wicgb1 with SMTP id gb1so19931196wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 02 Oct 2015 00:20:10 -0700 (PDT)
Date: Fri, 2 Oct 2015 09:20:03 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: nl802154: add support for security layer
Message-ID: <20151002071958.GA565@omega>
References: <20151001221755.GA13590@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151001221755.GA13590@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-wpan@vger.kernel.org

Hello Dan Carpenter,

On Fri, Oct 02, 2015 at 01:17:55AM +0300, Dan Carpenter wrote:
> Hello Alexander Aring,
> 
> The patch a26c5fd7622d: "nl802154: add support for security layer"
> from Sep 28, 2015, leads to the following static checker warning:
> 
> 	net/ieee802154/nl802154.c:1535 nl802154_add_llsec_key()
> 	warn: if statement not indented
> 
> net/ieee802154/nl802154.c
>   1530          if (nla_parse_nested(attrs, NL802154_KEY_ATTR_MAX,
>   1531                               info->attrs[NL802154_ATTR_SEC_KEY],
>   1532                               nl802154_key_policy))
>   1533                  return -EINVAL;
>   1534  
>   1535          if (!attrs[NL802154_KEY_ATTR_USAGE_FRAMES] ||
>   1536              !attrs[NL802154_KEY_ATTR_BYTES])
> 
> Should this be a return -EINVAL?
> 

Yes. Can you please provide a patch which based on bluetooth-next to
linux-wpan mailinglist?

Thanks.

- Alex
