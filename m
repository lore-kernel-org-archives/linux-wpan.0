Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24064 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJAWSP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Oct 2015 18:18:15 -0400
Date: Fri, 2 Oct 2015 01:17:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: nl802154: add support for security layer
Message-ID: <20151001221755.GA13590@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org

Hello Alexander Aring,

The patch a26c5fd7622d: "nl802154: add support for security layer"
from Sep 28, 2015, leads to the following static checker warning:

	net/ieee802154/nl802154.c:1535 nl802154_add_llsec_key()
	warn: if statement not indented

net/ieee802154/nl802154.c
  1530          if (nla_parse_nested(attrs, NL802154_KEY_ATTR_MAX,
  1531                               info->attrs[NL802154_ATTR_SEC_KEY],
  1532                               nl802154_key_policy))
  1533                  return -EINVAL;
  1534  
  1535          if (!attrs[NL802154_KEY_ATTR_USAGE_FRAMES] ||
  1536              !attrs[NL802154_KEY_ATTR_BYTES])

Should this be a return -EINVAL?

  1537  
  1538          if (ieee802154_llsec_parse_key_id(attrs[NL802154_KEY_ATTR_ID], &id) < 0)
  1539                  return -ENOBUFS;
  1540  

regards,
dan carpenter
