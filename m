Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A89CE7A94
	for <linux-wpan@archiver.kernel.org>; Mon, 25 Sep 2023 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjIYLgA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIYLgA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Sep 2023 07:36:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F5DA;
        Mon, 25 Sep 2023 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695641753; x=1727177753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A0N/3KD/SqIlzzRTtVUghnzqarLjTjUyuOAf9873lpc=;
  b=BwopjTaaOy+x8lSwycGUkgxA8HK4nUMsV3pJJgdhSU1ail/00xDnOnl8
   uP/4uLsmOU9g8nq5Y6eW5TD2W5ntLYAD+3bZNPn2oY/Dy2jemO0JMGDvl
   aLDPvCXlKsy/hbTr1KQ79JF8pMf9rkQFOycs47RFglYcaP6/wM87u+fcF
   7HbZ+tnvcA+DDqKKJ9b8p/4zA9HNzaEDah/yK7DvbifnjLrnyS8S3BZBR
   b0YmpWzWw/+xBNn/In2hWNZ/azJ8q7mpArf/GIIfm+ccHZo0HyQvVnCZp
   WIhy+x/ZfFlN+GrAuzTOHLkDF+n7JHdJlohX3VwRa14vynoIvopiXkluF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385058264"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="385058264"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 04:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891652378"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="891652378"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2023 04:34:47 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkjsR-0001Sr-10;
        Mon, 25 Sep 2023 11:35:47 +0000
Date:   Mon, 25 Sep 2023 19:35:22 +0800
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
Subject: Re: [PATCH wpan-next v4 04/11] mac802154: Handle associating
Message-ID: <202309251904.eSN2jHxq-lkp@intel.com>
References: <20230922155029.592018-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922155029.592018-5-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.6-rc3 next-20230925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/ieee802154-Let-PAN-IDs-be-reset/20230923-000250
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230922155029.592018-5-miquel.raynal%40bootlin.com
patch subject: [PATCH wpan-next v4 04/11] mac802154: Handle associating
config: i386-randconfig-061-20230925 (https://download.01.org/0day-ci/archive/20230925/202309251904.eSN2jHxq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251904.eSN2jHxq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251904.eSN2jHxq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/mac802154/cfg.c:379:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __le16 [usertype] pan_id @@     got int @@
   net/mac802154/cfg.c:379:39: sparse:     expected restricted __le16 [usertype] pan_id
   net/mac802154/cfg.c:379:39: sparse:     got int

vim +379 net/mac802154/cfg.c

   317	
   318	static int mac802154_associate(struct wpan_phy *wpan_phy,
   319				       struct wpan_dev *wpan_dev,
   320				       struct ieee802154_addr *coord)
   321	{
   322		struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
   323		u64 ceaddr = swab64((__force u64)coord->extended_addr);
   324		struct ieee802154_sub_if_data *sdata;
   325		struct ieee802154_pan_device *parent;
   326		__le16 short_addr;
   327		int ret;
   328	
   329		ASSERT_RTNL();
   330	
   331		sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
   332	
   333		if (wpan_dev->parent) {
   334			dev_err(&sdata->dev->dev,
   335				"Device %8phC is already associated\n", &ceaddr);
   336			return -EPERM;
   337		}
   338	
   339		if (coord->mode == IEEE802154_SHORT_ADDRESSING)
   340			return -EINVAL;
   341	
   342		parent = kzalloc(sizeof(*parent), GFP_KERNEL);
   343		if (!parent)
   344			return -ENOMEM;
   345	
   346		parent->pan_id = coord->pan_id;
   347		parent->mode = coord->mode;
   348		parent->extended_addr = coord->extended_addr;
   349		parent->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
   350	
   351		/* Set the PAN ID hardware address filter beforehand to avoid dropping
   352		 * the association response with a destination PAN ID field set to the
   353		 * "new" PAN ID.
   354		 */
   355		if (local->hw.flags & IEEE802154_HW_AFILT) {
   356			ret = drv_set_pan_id(local, coord->pan_id);
   357			if (ret < 0)
   358				goto free_parent;
   359		}
   360	
   361		ret = mac802154_perform_association(sdata, parent, &short_addr);
   362		if (ret)
   363			goto reset_panid;
   364	
   365		if (local->hw.flags & IEEE802154_HW_AFILT) {
   366			ret = drv_set_short_addr(local, short_addr);
   367			if (ret < 0)
   368				goto reset_panid;
   369		}
   370	
   371		wpan_dev->pan_id = coord->pan_id;
   372		wpan_dev->short_addr = short_addr;
   373		wpan_dev->parent = parent;
   374	
   375		return 0;
   376	
   377	reset_panid:
   378		if (local->hw.flags & IEEE802154_HW_AFILT)
 > 379			drv_set_pan_id(local, IEEE802154_PAN_ID_BROADCAST);
   380	
   381	free_parent:
   382		kfree(parent);
   383		return ret;
   384	}
   385	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
