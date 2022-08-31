Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED8DECAAD1
	for <linux-wpan@archiver.kernel.org>; Wed, 31 Aug 2022 18:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiHaSgA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiHaSfh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Aug 2022 14:35:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC78F0772;
        Wed, 31 Aug 2022 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661970685; x=1693506685;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o2Ftrt6s6ruHdV2MNerq/oWUDP4gJYggV0CnYVZ6fa8=;
  b=gDLnY2EZ/UPWSs98t1b/G4zu/xpintAOV63f8BLHfne4iMBVuVR8bVPm
   iqPSFauZxTWatXaJ1VmWv/FrHiMYUvHdNzA70G+rJiqrksAS5aBrj+kkI
   dnvjFvUQXocd6SM0+ymJA0ZeAkVNCpWBSiEe081AFsqkPHiuqxhQXgwJz
   vWIhTPXe9uTZGISLWfWNpDT01J+VZFJYgkcEIvdTgtlYRYgj1MIzB8Z6T
   vBgY3jLVovOEtrsQbxtRM3CW04Ow/PWQzEjztz0QIRGfvcBTJr5ey8NK/
   ZIwImfrXVNUdhDAuQmaRW5cPwPX+Tj2L76yEwfGuTzlIIKmBnzEpCGXVZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321657382"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321657382"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563132886"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 11:31:22 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTSUk-0000a6-00;
        Wed, 31 Aug 2022 18:31:22 +0000
Date:   Thu, 01 Sep 2022 02:30:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-wpan@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 7fd22855300e693668c3397771b3a2b3948f827a
Message-ID: <630fa8c5.moZxX4/JNtIfjYQO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 7fd22855300e693668c3397771b3a2b3948f827a  Add linux-next specific files for 20220831

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209010004.BZ0Et3LM-lkp@intel.com
https://lore.kernel.org/llvm/202208312208.HjwleIeN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regmap-mmio.c:221:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:224:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:227:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writesl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readsl'? [-Werror=implicit-function-declaration]
drivers/platform/mellanox/mlxreg-lc.c:866 mlxreg_lc_probe() warn: passing zero to 'PTR_ERR'
net/ieee802154/nl802154.c:2503:26: error: 'NL802154_CMD_DEL_SEC_LEVEL' undeclared here (not in a function); did you mean 'NL802154_CMD_SET_CCA_ED_LEVEL'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-randconfig-r024-20220830
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- arc-randconfig-r002-20220830
|   `-- net-ieee802154-nl802154.c:error:NL802154_CMD_DEL_SEC_LEVEL-undeclared-here-(not-in-a-function)
|-- i386-randconfig-s001
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- i386-randconfig-s002
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- i386-randconfig-s003
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- parisc-randconfig-r012-20220831
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- powerpc-randconfig-s053-20220830
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- s390-randconfig-s052-20220830
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- sparc-allyesconfig
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|-- sparc-buildonly-randconfig-r005-20220830
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|-- sparc64-buildonly-randconfig-r006-20220830
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|-- sparc64-randconfig-c042-20220830
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- net-ieee802154-nl802154.c:error:NL802154_CMD_DEL_SEC_LEVEL-undeclared-here-(not-in-a-function)
clang_recent_errors
`-- arm-randconfig-r006-20220830
    `-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-function-imu_v11_0_3_program_rlc_ram

elapsed time: 725m

configs tested: 76
configs skipped: 2

gcc tested configs:
arc                        vdk_hs38_defconfig
arm                           u8500_defconfig
arm                          badge4_defconfig
arm                           tegra_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           alldefconfig
i386                                defconfig
arm                         nhk8815_defconfig
x86_64                              defconfig
xtensa                  cadence_csp_defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
arm                          simpad_defconfig
x86_64                          rhel-8.3-func
m68k                           virt_defconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
arm                      footbridge_defconfig
i386                          randconfig-a003
ia64                                defconfig
arc                  randconfig-r043-20220830
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                           allyesconfig
sparc                            alldefconfig
csky                              allnoconfig
sh                               allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
mips                             allyesconfig
arm                                 defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
i386                          randconfig-a014
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
ia64                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                         axm55xx_defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
arm                            mmp2_defconfig
i386                          randconfig-a002
hexagon              randconfig-r045-20220830
x86_64                        randconfig-a012
riscv                randconfig-r042-20220830
i386                          randconfig-a006
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
arm                       mainstone_defconfig
arm                        magician_defconfig
riscv                          rv32_defconfig
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
