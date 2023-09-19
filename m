Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E621FCD342E
	for <linux-wpan@archiver.kernel.org>; Tue, 19 Sep 2023 03:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjISDLc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 23:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISDLb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 23:11:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D8119;
        Mon, 18 Sep 2023 20:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695093085; x=1726629085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//n56qSOGpYjB+Tw3lFwSa+S8fDa2+ZU1y1haKxm4iY=;
  b=Y0vJSIAda41cB6a6hMxsIjLKf9s3B1PhNoOhlqDuucQVgRWksxHavu3x
   YoIdXXZ3rtzS16mUye5cSU1TwIxodUBM0Kszf4XqW0qfuosrlPDC7FJQy
   T4o3ggEOxRYDemaSLKGUQD0GTMCJ/1b39xv5fffdI/+t0BTtbQYCil3wA
   D+xXrIHJsZvcuyt9ClQswdqPb0ITU4yDgqGuYsoEHH5B/Lcc6bNQgF5vK
   2ruj48wUTz35WGGfrhotwMz/QleuNjcOiltqQNuzQpO3ZTqkozgru2HDP
   nYWtonTAJh+gF9ujTo/DFIMvudtj3bLctbv0UVUC5b2goX0QCIHtFjmMv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378740633"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="378740633"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 20:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992995676"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="992995676"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Sep 2023 20:11:20 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiR8w-0006pQ-1V;
        Tue, 19 Sep 2023 03:11:18 +0000
Date:   Tue, 19 Sep 2023 11:10:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH wpan-next v3 11/11] ieee802154: Give the user the
 association list
Message-ID: <202309191044.4ABvPP5X-lkp@intel.com>
References: <20230918150809.275058-12-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918150809.275058-12-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.6-rc2 next-20230918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/ieee802154-Let-PAN-IDs-be-reset/20230919-002634
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230918150809.275058-12-miquel.raynal%40bootlin.com
patch subject: [PATCH wpan-next v3 11/11] ieee802154: Give the user the association list
config: powerpc64-randconfig-001-20230919 (https://download.01.org/0day-ci/archive/20230919/202309191044.4ABvPP5X-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191044.4ABvPP5X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309191044.4ABvPP5X-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ieee802154/nl802154.c: In function 'nl802154_list_associations':
>> net/ieee802154/nl802154.c:1778:15: error: implicit declaration of function 'nl802154_prepare_wpan_dev_dump' [-Werror=implicit-function-declaration]
    1778 |         err = nl802154_prepare_wpan_dev_dump(skb, cb, &rdev, &wpan_dev);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/ieee802154/nl802154.c:1811:9: error: implicit declaration of function 'nl802154_finish_wpan_dev_dump' [-Werror=implicit-function-declaration]
    1811 |         nl802154_finish_wpan_dev_dump(rdev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nl802154_prepare_wpan_dev_dump +1778 net/ieee802154/nl802154.c

  1769	
  1770	static int nl802154_list_associations(struct sk_buff *skb,
  1771					      struct netlink_callback *cb)
  1772	{
  1773		struct cfg802154_registered_device *rdev;
  1774		struct ieee802154_pan_device *child;
  1775		struct wpan_dev *wpan_dev;
  1776		int err;
  1777	
> 1778		err = nl802154_prepare_wpan_dev_dump(skb, cb, &rdev, &wpan_dev);
  1779		if (err)
  1780			return err;
  1781	
  1782		mutex_lock(&wpan_dev->association_lock);
  1783	
  1784		if (cb->args[2])
  1785			goto out;
  1786	
  1787		if (wpan_dev->parent) {
  1788			err = nl802154_send_peer_info(skb, cb, cb->nlh->nlmsg_seq,
  1789						      NLM_F_MULTI, rdev, wpan_dev,
  1790						      wpan_dev->parent,
  1791						      NL802154_PEER_TYPE_PARENT);
  1792			if (err < 0)
  1793				goto out_err;
  1794		}
  1795	
  1796		list_for_each_entry(child, &wpan_dev->children, node) {
  1797			err = nl802154_send_peer_info(skb, cb, cb->nlh->nlmsg_seq,
  1798						      NLM_F_MULTI, rdev, wpan_dev,
  1799						      child,
  1800						      NL802154_PEER_TYPE_CHILD);
  1801			if (err < 0)
  1802				goto out_err;
  1803		}
  1804	
  1805		cb->args[2] = 1;
  1806	out:
  1807		err = skb->len;
  1808	out_err:
  1809		mutex_unlock(&wpan_dev->association_lock);
  1810	
> 1811		nl802154_finish_wpan_dev_dump(rdev);
  1812	
  1813		return err;
  1814	}
  1815	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
