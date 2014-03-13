#pragma once
#include <string>
#include "MemoryLeakDetector.h"

namespace xihad { namespace ngn
{
	class ComponentSystem;
	class GameScene;
	/// ���ϵͳ�Ĺ�����
	/**
	 * һ���������Դ�������ϵͳ��ÿ��ϵͳ��һ����Ӧ�ı�ʶ�����ñ�ʶ����ʾ�����ϵͳ���Դ���
	 * �������͵������ͨ���÷����£�
	 * <pre>
	 *		system = systemFactory->create(scene, "mesh");
	 *		component = system->create("mesh", object, param);
	 * </pre>
	 * 
	 * @author etnlGD
	 * @date 2013��12��13�� 16:21:38
	 */
	class ComponentSystemFactory
	{
	public:
		ComponentSystemFactory() { XIHAD_MLD_NEW_OBJECT; }

		virtual ~ComponentSystemFactory() { XIHAD_MLD_DEL_OBJECT; }

		/// �������������ϵͳ
		/**
		 * @see GameScene::requireSystem()
		 * @param scene ָ�����󴴽����ϵͳ����Ϸ����
		 * @param typeName ָ�����������
		 * @return ����һ�����Դ��� typeName ��ָ����������͵����ϵͳ
		 */
		virtual ComponentSystem* create(
			GameScene* scene, const std::string& typeName) = 0;
	};
}}
